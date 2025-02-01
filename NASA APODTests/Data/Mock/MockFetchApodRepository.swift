//
//  MockFetchApodRepository.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import Foundation
@testable import NASA_APOD

final class MockFetchApodRepository: FetchApodRepositoryProtocol {
    let error: NSError?
    let apod: APOD
    
    init(error: NSError? = nil, apod: APOD) {
        self.error = error
        self.apod = apod
    }

    var query: GetApodEndpoint.Query?
    
    func fetchApod(query: GetApodEndpoint.Query) async throws -> APOD {
        self.query = query
        
        if let error {
            throw error
        } else {
            return apod
        }
    }
}
