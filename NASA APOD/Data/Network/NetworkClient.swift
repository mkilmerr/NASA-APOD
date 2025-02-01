//
//  NetworkClient.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

final class NetworkClient: HTTPClient {
    private let baseURL = "https://api.nasa.gov/planetary"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard var urlComponents = URLComponents(string: baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decoder = try JSONDecoder().decode(T.self, from: data)
            return decoder
        } catch {
            throw NetworkError.decodingError
        }
    }
}
