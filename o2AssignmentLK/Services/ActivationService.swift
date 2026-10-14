//
//  ActivationService.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

protocol ActivationService {
    func activate(code: UUID) async throws -> ActivationResponse
}
