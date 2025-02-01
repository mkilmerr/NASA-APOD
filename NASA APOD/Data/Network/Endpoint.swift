//
//  Endpoint.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
