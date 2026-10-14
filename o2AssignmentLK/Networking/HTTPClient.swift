//
//  HTTPClient.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

@MainActor
struct HTTPClient {
    let session: URLSession

    func send<Response: Decodable>(
        _ request: URLRequest,
        as responseType: Response.Type
    ) async throws -> Response {
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw AppError.network(.invalidResponse)
        }

        guard (200..<300).contains(response.statusCode) else {
            throw AppError.network(.invalidStatusCode(response.statusCode))
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(responseType, from: data)
    }
}
