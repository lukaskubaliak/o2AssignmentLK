//
//  RequestActivationService.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

struct RequestActivationService: ActivationService {
    let client: HTTPClient
    let endpoint: String
    
    init() {
        self.client = HTTPClient(session: .shared)
        self.endpoint = "https://api.o2.sk/version"
    }
    
    func activate(code: UUID) async throws(AppError) -> ActivationResponse {
        var components = URLComponents(string: endpoint)
        let activationRequest = ActivationRequest(code: code)
        components?.queryItems = activationRequest.queryItems
        
        guard let url = components?.url else {
            throw .network(.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let response = try await client.send(request, as: ActivationResponse.self)
            debugPrint(response)
            
            return response
        } catch {
            throw .network(.decodingFailed)
        }
    }
}
