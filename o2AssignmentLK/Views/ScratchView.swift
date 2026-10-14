//
//  ScratchCardView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import SwiftUI

struct ScratchView: View {
    @Environment(\.scratchCardStore) private var scratchCardStore
    @State private var scratchTask: Task<Void, Never>?
    
    private var isScratching: Bool {
        scratchCardStore.state == .scratching
    }
    
    var body: some View {
        ScratchCardView(
            scratchCard: scratchCardStore.card,
            isScratching: isScratching
        )
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            ActionButton(title: "Scratch the card!", isLoading: scratchCardStore.state == .scratching) {
                scratchTask = Task {
                    await scratchCardStore.scratch()
                }
            }
            .disabled(!scratchCardStore.card.state.canBeScratched || isScratching)
        }
        .padding()
        .onDisappear {
            scratchTask?.cancel()
            scratchTask = nil
        }
    }
}

#Preview {
    RouterView {
        ScratchView()
    }
}
