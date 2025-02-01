//
//  HTTPClient.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

protocol HTTPClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
