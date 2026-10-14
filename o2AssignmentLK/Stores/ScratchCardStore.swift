//
//  ScratchCardStore.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

@MainActor @Observable final class ScratchCardStore {
    enum State {
        case idle
        case scratching
    }
    
    private(set) var card = ScratchCard(id: UUID())
    private(set) var error: AppError?
    private(set) var state: State = .idle
    
    func scratch() async {
        guard case .idle = state, card.state.canBeScratched else { return }
        
        defer { state = .idle }
        do {
            state = .scratching
            try await Task.sleep(for: .seconds(2))
            card.state = .scratched(code: UUID())
        } catch {
            self.error = .scratchError
        }
    }

    func activate() async {
        // API požiadavka
    }
}

extension EnvironmentValues {
    @Entry var scratchCardStore = ScratchCardStore()
}
