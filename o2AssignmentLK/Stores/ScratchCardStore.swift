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
    private var state: State = .idle
    
    func scratch() async {
        guard case .idle = state else { return }
        
        do {
            state = .scratching
            try await Task.sleep(for: .seconds(2))
            card.state = .scratched(code: UUID())
            state = .idle
        } catch {
            // TODO: throw error
        }
    }

    func activate() async {
        // API požiadavka
    }
}

extension EnvironmentValues {
    @Entry var scratchCardStore = ScratchCardStore()
}
