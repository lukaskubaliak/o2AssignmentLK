//
//  HomeView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.router) private var router
    @Environment(\.scratchCardStore) private var scratchCardStore
    
    private var title: String {
        "Your card is \(scratchCardStore.card.state.description.uppercased())"
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 24) {
                ScratchCardView(scratchCard: scratchCardStore.card)
                
                Text(title)
                    .font(.headline)
                    .foregroundStyle(scratchCardStore.card.state.foregroundStyle)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .safeAreaBar(edge: .bottom) {
            HStack(spacing: 12) {
                ActionButton(title: "Scratch card") {
                    router.push(.scratchView)
                }
                .disabled(!scratchCardStore.card.state.canBeScratched)
                
                ActionButton(title: "Activate card") {
                    router.push(.activateView)
                }
                .actionButtonStyle(.secondary)
                .disabled(!scratchCardStore.card.state.canBeActivated)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Reset card", role: .destructive) {
                        scratchCardStore.reset()
                    }
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
    }
    
    var body: some View {
        contentView
            .navigationTitle("Your card")
    }
}

#Preview {
    RouterView {
        HomeView()
    }
}
