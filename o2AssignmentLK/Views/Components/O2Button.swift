//
//  O2Button.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

enum O2ButtonType {
    case primary
    case secondary
    
    var backgroundColor: Color {
        switch self {
        case .primary: .blue
        case .secondary: .gray.opacity(0.3)
        }
    }
    
    var disabledBackgroundColor: Color {
        .gray.opacity(0.3)
    }
    
    var pressedBackgroundColor: Color {
        switch self {
        case .primary: .blue.opacity(0.5)
        case .secondary: .gray.opacity(0.1)
        }
    }
    
    var foregroundStyle: Color {
        switch self {
        case .primary: .white
        case .secondary: .secondary
        }
    }
    
    var disabledForegroundStyle: Color {
        .gray.opacity(0.5)
    }
}

struct O2Button: View {
    private let title: String
    private let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(O2ButtonStyle())
    }
}

fileprivate struct O2ButtonStyle: ButtonStyle {
    @Environment(\.o2ButtonType) private var type
    @Environment(\.isEnabled) private var isEnabled
    
    fileprivate func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(isEnabled ? type.foregroundStyle : type.disabledForegroundStyle)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background {
                if configuration.isPressed {
                    type.pressedBackgroundColor
                } else {
                    isEnabled ? type.backgroundColor : type.disabledBackgroundColor
                }
            }
            .clipShape(.rect(cornerRadius: 12))
    }
}

extension View {
    func o2ButtonStyle(_ type: O2ButtonType) -> some View {
        transformEnvironment(\.o2ButtonType) {
            $0 = type
        }
    }
}

extension EnvironmentValues {
    @Entry fileprivate var o2ButtonType: O2ButtonType = .primary
}

#Preview {
    O2Button(title: "Title", action: { })
        .o2ButtonStyle(.secondary)
}
