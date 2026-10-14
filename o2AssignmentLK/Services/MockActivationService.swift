//
//  MockActivationService.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

struct MockActivationService: ActivationService {
    let iosVersion: String
    let delay: Duration
    
    func activate(code: UUID) async throws -> ActivationResponse {
        try await Task.sleep(for: delay)
        return ActivationResponse(ios: iosVersion)
    }
}
