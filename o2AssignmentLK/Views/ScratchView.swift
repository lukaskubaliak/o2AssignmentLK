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
    
    var body: some View {
        ScratchCardView(
            scratchCard: scratchCardStore.card,
            isScratching: scratchCardStore.state == .scratching
        )
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            O2Button(title: "Scratch the card!") {
                scratchTask = Task {
                    await scratchCardStore.scratch()
                }
            }
            .disabled(!scratchCardStore.card.state.canBeScratched)
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
