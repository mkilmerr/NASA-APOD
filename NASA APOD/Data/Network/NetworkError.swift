//
//  NetworkError.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}
