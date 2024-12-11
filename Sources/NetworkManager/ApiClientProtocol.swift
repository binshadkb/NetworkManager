//
//  ApiClientProtocol.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public protocol ApiClientProtocol {
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
    func excecute<T: Decodable>(dataType: T.Type, urlRequest: URLRequest) async throws -> T
}

extension ApiClientProtocol {
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
                        
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Date string does not match any expected format."
            )
        }
    }
}
