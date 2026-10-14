//
//  AppErrorAlertModifier.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import SwiftUI

struct AppErrorAlertModifier: ViewModifier {
    let store: ScratchCardStore
    
    func body(content: Content) -> some View {
        content
            .alert(
                store.error?.title ?? AppError.generalTitle,
                isPresented: Binding(
                    get: { store.error != nil },
                    set: { isPresented in
                        guard isPresented else { return }
                        
                        store.clearError()
                    }
                ),
                actions: {
                    Button("OK") {}
                }
            )
    }
}

extension View {
    func appErrorAlert(store: ScratchCardStore) -> some View {
        modifier(
            AppErrorAlertModifier(store: store)
        )
    }
}
