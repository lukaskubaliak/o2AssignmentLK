//
//  AppError.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

enum AppError: Error {
    case domain(DomainError)
    case network(NetworkError)
    
    static let generalMessage = "An unknown error occurred. Please try again."
    static let generalTitle = "Something went wrong."
    
    var title: String {
        switch self {
        case let .domain(error): error.title
        case .network: "Network Error"
        }
    }

    var message: String {
        switch self {
        case let .domain(error): error.message
        case let .network(error): error.message
        }
    }
}

enum DomainError: Error {
    case scratchError
    case activationError
    case unknown(reason: String? = nil)
    
    var title: String {
        switch self {
        case .scratchError: "Scratch Failed"
        case .activationError: "Activation Failed"
        case .unknown: AppError.generalTitle
        }
    }

    var message: String {
        switch self {
        case .scratchError: "Unable to complete the scratch operation. Please try again."
        case .activationError: "The card could not be activated."
        case let .unknown(reason): reason ?? AppError.generalMessage
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
    
    var message: String {
        switch self {
        case .invalidURL: "The requested URL is invalid."
        case .invalidResponse: "The server returned an invalid response."
        case let .invalidStatusCode(statusCode): "The server returned status code \(statusCode)."
        case .decodingFailed: "The server response could not be processed."
        }
    }
}
