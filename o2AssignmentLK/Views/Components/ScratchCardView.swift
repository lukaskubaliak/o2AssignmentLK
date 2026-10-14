//
//  ScratchCardView.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

struct ScratchCardView: View {
    private let scratchCard: ScratchCard
    private let isScratching: Bool
    
    @State private var isPulsing = false
    
    init(scratchCard: ScratchCard, isScratching: Bool = false) {
        self.scratchCard = scratchCard
        self.isScratching = isScratching
    }
    
    private var code: String {
        switch scratchCard.state {
        case .unscratched: ""
        case .scratched(let code): "\(code)"
        case .activated(let code): "\(code)"
        }
    }
    
    private var codeView: some View {
        Text(code)
            .font(.callout)
            .fontWeight(.medium)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Your Scratch Card")
                .font(.title3)
                .fontWeight(.semibold)
            
            codeView
                .opacity(isPulsing ? 0.8 : 1)
                .scaleEffect(isPulsing ? 1.02 : 1)
                .onChange(of: isScratching, initial: true) { _, isScratching in
                    if isScratching {
                        withAnimation(
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                        ) {
                            isPulsing = true
                        }
                    } else {
                        withAnimation {
                            isPulsing = false
                        }
                    }
                }
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
