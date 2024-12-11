//
//  URLBuilder.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public class URLBuilder: URLBuilderProtocol {
    public func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], bodyParams: Any?) -> URLRequest? {
        
        guard var components = URLComponents(string: baseURL + path) else {
            return nil
        }
       
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let bodyParams = bodyParams as? Encodable {
            do {
                let jsonData = try JSONEncoder().encode(bodyParams)
                urlRequest.httpBody = jsonData
            }
            catch {
                return nil
            }
        }
        
        return urlRequest
    }
    
    public func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: baseURL + path)
       
        components?.queryItems = queryItems

        return components?.url
    }
    
    public func buildMultiPartURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], dataArray: [MultiPartModel]) -> URLRequest? {
        
        guard var components = URLComponents(string: baseURL + path) else {
            return nil
        }
       
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        for dataItem in  dataArray {
            body += Data("--\(boundary)\r\n".utf8)
            body += Data("Content-Disposition: form-data; name=\"\(dataItem.key)\"".utf8)
            
            if dataItem.type == .file {
                body += Data("; filename=\"\(dataItem.key)\"\r\n".utf8)
                body += Data("Content-Type: \"content-type header\"\r\n".utf8)
                
                body += Data("\r\n".utf8)
                body += dataItem.data
                body += Data("\r\n".utf8)
            }
            else {
                let type = "application/json"
                body += Data("\r\nContent-Type: \(type)\r\n\r\n".utf8)
                body.append(dataItem.data)
                body.append(Data("\r\n".utf8))
            }
            
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
