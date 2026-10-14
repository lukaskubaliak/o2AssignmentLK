//
//  ActivationRequest.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

struct ActivationRequest {
    let code: UUID
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(
                name: "code",
                value: code.uuidString
            )
        ]
    }
}
