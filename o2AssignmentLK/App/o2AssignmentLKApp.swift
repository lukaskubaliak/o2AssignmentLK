//
//  o2AssignmentLKApp.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 13/10/2026.
//

import SwiftUI

@main
struct o2AssignmentLKApp: App {
    @State private var store = ScratchCardStore()
    
    var body: some Scene {
        WindowGroup {
            RouterView {
                HomeView()
            }
            .environment(\.scratchCardStore, store)
        }
    }
}

struct RouterView<Content: View>: View {
    private let content: Content
    @State private var router = Router()
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .scratchView: ScratchView()
                    case .activateView: ActivateView()
                    }
                }
        }
        .environment(\.router, router)
    }
}
