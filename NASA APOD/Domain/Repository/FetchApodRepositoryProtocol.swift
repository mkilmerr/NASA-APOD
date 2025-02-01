//
//  FetchApodRepositoryProtocol.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

protocol FetchApodRepositoryProtocol {
    func fetchApod(query: GetApodEndpoint.Query) async throws-> APOD
}
