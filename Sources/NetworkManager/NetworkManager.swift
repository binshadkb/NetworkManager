// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class NetworkManager: ApiClientProtocol {
    func excecute<T>(dataType: T.Type, urlRequest: URLRequest) async throws -> T where T : Decodable {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case HTTPStatusCode.success.rawValue:
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                return try decoder.decode(dataType, from: data)
            }
            catch {
                print(error)
                throw ApiError.parseError
            }
        case HTTPStatusCode.unauthorized.rawValue:
            throw ApiError.unauthozized
            
        case HTTPStatusCode.internalServerError.rawValue:
            throw ApiError.internalServerError
            
        default:
            throw ApiError.httpError(httpResponse.statusCode)
        }
    }
    
    func excecute(urlRequest: URLRequest) async throws -> String? {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case HTTPStatusCode.success.rawValue:
            return String(data: data, encoding: .utf8)
        case HTTPStatusCode.unauthorized.rawValue:
            throw ApiError.unauthozized
            
        case HTTPStatusCode.internalServerError.rawValue:
            throw ApiError.internalServerError
            
        default:
            throw ApiError.httpError(httpResponse.statusCode)
        }
    }
}
