//
//  O2Button.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

enum ActionButtonType {
    case primary
    case secondary
    
    var backgroundColor: Color {
        switch self {
        case .primary: .blue
        case .secondary: .white
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
    
    var borderColor: Color {
        switch self {
        case .primary: .blue
        case .secondary: .secondary
        }
    }
}

struct ActionButton: View {
    private let title: String
    private let action: () -> Void
    private var isLoading: Bool
    
    init(
        title: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(ActionButtonStyle(isLoading: isLoading))
    }
}

fileprivate struct ActionButtonStyle: ButtonStyle {
    @Environment(\.actionButtonStyle) private var type
    @Environment(\.isEnabled) private var isEnabled
    
    private var isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    fileprivate func makeBody(configuration: Configuration) -> some View {
        HStack {
            if isLoading {
                ProgressView()
            }
            
            configuration.label
                .foregroundStyle(isEnabled ? type.foregroundStyle : type.disabledForegroundStyle)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background {
            if configuration.isPressed {
                type.pressedBackgroundColor
            } else {
                isEnabled ? type.backgroundColor : type.disabledBackgroundColor
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(isEnabled ? type.borderColor : .clear, lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: 12))
        .animation(.default, value: isLoading)
    }
}

extension View {
    func actionButtonStyle(_ type: ActionButtonType) -> some View {
        transformEnvironment(\.actionButtonStyle) {
            $0 = type
        }
    }
}

extension EnvironmentValues {
    @Entry fileprivate var actionButtonStyle: ActionButtonType = .primary
}

#Preview {
    ActionButton(title: "Title", isLoading: true, action: { })
        .actionButtonStyle(.secondary)
}
