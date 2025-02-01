//
//  FetchApodRepository.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

final class FetchApodRepository: FetchApodRepositoryProtocol {
    private let networkClient: HTTPClient

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }

    func fetchApod(query: GetApodEndpoint.Query) async throws-> APOD {
        let endpoint = GetApodEndpoint(query: query)
        let response: APOD = try await networkClient.request(endpoint)
        return response
    }
}
