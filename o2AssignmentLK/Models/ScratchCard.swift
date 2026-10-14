//
//  Card.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

struct ScratchCard {
    let id: AnyHashable
    var state: ScratchCardState
    
    init(id: some Hashable, state: ScratchCardState = .unscratched) {
        self.id = AnyHashable(id)
        self.state = state
    }
}

enum ScratchCardState: Equatable {
    case unscratched
    case scratched(code: UUID)
    case activated(code: UUID)
    
    var description: String {
        switch self {
        case .unscratched: "Unscratched"
        case .scratched: "Scratched"
        case .activated: "Activated"
        }
    }

    var foregroundStyle: Color {
        switch self {
        case .unscratched: .secondary
        case .scratched: .blue
        case .activated: .green
        }
    }

    var canBeScratched: Bool {
        switch self {
        case .unscratched: true
        default: false
        }
    }

    var canBeActivated: Bool {
        switch self {
        case .scratched: true
        default: false
        }
    }
}
