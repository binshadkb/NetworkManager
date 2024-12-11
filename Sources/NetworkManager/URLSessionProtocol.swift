//
//  URLSessionProtocol.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
