//
//  ScratchCardStore.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

@MainActor @Observable final class ScratchCardStore {
    enum State: Equatable {
        case idle
        case scratching
        case activating
    }
    
    private let activationService: any ActivationService
    private let scratchDuration: Duration
    private(set) var card = ScratchCard(id: UUID())
    private(set) var state: State = .idle
    private(set) var error: AppError?
    
    init(
        activationService: any ActivationService,
        scratchDuration: Duration = .seconds(2)
    ) {
        self.activationService = activationService
        self.scratchDuration = scratchDuration
    }
    
    func scratch() async {
        guard case .idle = state, card.state.canBeScratched else { return }
        
        defer { state = .idle }
        do {
            state = .scratching
            try await Task.sleep(for: scratchDuration)
            card.state = .scratched(code: UUID())
        } catch is CancellationError {
            // Leaving ScratchView intentionally cancels this operation.
        } catch {
            self.error = .domain(.scratchError)
        }
    }

    func activate() async {
        guard case let .scratched(code) = card.state else { return }
        
        defer { state = .idle }
        do {
            state = .activating
            let response = try await activationService.activate(code: code)
            let isActivated = response.ios.compare("6.1", options: .numeric) == .orderedDescending
            
            if isActivated {
                card.state = .activated(code: code)
            } else {
                error = .domain(.activationError)
            }
        } catch let error as AppError {
            self.error = error
        } catch {
            self.error = .domain(.unknown(reason: error.localizedDescription))
        }
    }
    
    func clearError() {
        error = nil
    }
}

extension ScratchCardStore {
    func reset() {
        guard case .idle = state else { return }
        
        card = ScratchCard(id: UUID())
        error = nil
    }
}

extension EnvironmentValues {
    @Entry var scratchCardStore = ScratchCardStore(activationService: RequestActivationService())
}
