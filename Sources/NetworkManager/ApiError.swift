//
//  ApiError.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public enum ApiError: Error {
    case invalidResponse
    case parseError
    case unauthozized
    case internalServerError
    case invalidUrl
    case httpError(Int)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response received from the server."
        case .parseError:
            return "Error parsing server response."
        case .unauthozized:
            return "Invalid username or password"
        case .internalServerError:
            return "Internal server error. Please try again later."
        case .httpError(let statusCode):
            return "HTTP error with status code \(statusCode)."
        case .invalidUrl:
            return "Invalid url"
        }
    }
}
