//
//  AppError.swift
//  o2AssignmentLK
//
//  Created by Lukáš Kubaliak on 14/10/2026.
//

import Foundation

enum AppError: Error {
    case scratchError
    case unknown(reason: String? = nil)
    
    static let generalMessage = "An unknown error occurred. Please try again."
    static let generalTitle = "Something went wrong."
    
    var title: String {
        switch self {
        case .scratchError: "Scratch Error"
        case .unknown: AppError.generalTitle
        }
    }
    
    var message: String {
        switch self {
        case .scratchError: "Unable to complete the scratch operation. Please try again."
        case .unknown(let reason): reason ?? AppError.generalMessage
        }
    }
}
