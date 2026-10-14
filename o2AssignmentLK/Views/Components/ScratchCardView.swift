//
//  ScratchCardView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

struct ScratchCardView: View {
    private let scratchCard: ScratchCard
    
    init(scratchCard: ScratchCard) {
        self.scratchCard = scratchCard
    }
    
    private var code: String {
        switch scratchCard.state {
        case .unscratched: ""
        case .scratched(let code): "\(code)"
        case .activated(let code): "\(code)"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Your Scratch Card")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(code)
                .font(.callout)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, minHeight: 24)
                .padding(4)
                .background(.secondary.opacity(0.4))
                .overlay {
                    if case .unscratched = scratchCard.state {
                        Rectangle()
                            .background(.ultraThickMaterial)
                    }
                }
                .clipShape(.rect(cornerRadius: 8))
        }
        .padding(16)
        .padding(.bottom, 8)
        .clipShape(.rect(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(scratchCard.state.foregroundStyle, lineWidth: 1)
        )
    }
}

#Preview {
    ScratchCardView(
        scratchCard: .init(id: "1")
    )
}
