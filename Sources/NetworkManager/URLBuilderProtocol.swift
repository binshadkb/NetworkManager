//
//  URLBuilderProtocol.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public protocol URLBuilderProtocol {
    func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], bodyParams: Any?) -> URLRequest?
    func buildMultiPartURL(baseURL: String, path: String, queryItems: [URLQueryItem]?, httpMethod: String, headers: [String: String], dataArray: [MultiPartModel]) -> URLRequest?
}
