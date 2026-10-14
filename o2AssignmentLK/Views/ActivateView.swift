//
//  ActivateView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import SwiftUI

struct ActivateView: View {
    @Environment(\.scratchCardStore) private var scratchCardStore
    
    var body: some View {
        ScratchCardView(
            scratchCard: scratchCardStore.card,
            isScratching: scratchCardStore.state == .scratching
        )
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            ActionButton(title: "Activate your code!", isLoading: scratchCardStore.state == .activating) {
                Task {
                    await scratchCardStore.activate()
                }
            }
            .disabled(
                !scratchCardStore.card.state.canBeActivated ||
                scratchCardStore.state == .activating
            )
        }
        .padding()
    }
}

#Preview {
    RouterView {
        ActivateView()
    }
}
