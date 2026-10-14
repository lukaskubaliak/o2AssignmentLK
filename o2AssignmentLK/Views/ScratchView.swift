//
//  ScratchCardView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import SwiftUI

struct ScratchView: View {
    @Environment(\.scratchCardStore) private var scratchCardStore
    
    var body: some View {
        ScratchCardView(scratchCard: scratchCardStore.card)
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                O2Button(title: "Scratch the card!") {
                    
                }
            }
            .padding()
    }
}

#Preview {
    ScratchView()
}
