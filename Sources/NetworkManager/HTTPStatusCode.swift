//
//  HTTPStatusCode.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public enum HTTPStatusCode: Int {
    case success =  200
    case unauthorized = 401
    case internalServerError = 500
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .unauthorized:
            return "Unauthorized"
        case .internalServerError:
            return "Internal Server Error"
        }
    }
}
