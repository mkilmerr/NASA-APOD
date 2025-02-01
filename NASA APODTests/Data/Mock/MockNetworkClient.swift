//
//  MockNetworkClient.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import Foundation
@testable import NASA_APOD

final class MockNetworkClient: HTTPClient {
    var mockResult: Result<APOD, Error>?
    var lastRequestedEndpoint: Endpoint?
    
    func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        lastRequestedEndpoint = endpoint
        guard let result = mockResult else {
            fatalError("Mock result not set")
        }
        switch result {
        case .success(let apod):
            return apod as! T
        case .failure(let error):
            throw error
        }
    }
}
