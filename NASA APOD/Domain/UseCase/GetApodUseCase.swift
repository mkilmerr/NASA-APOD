//
//  GetApodUseCase.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

protocol GetApodUseCaseProtocol {
    func execute(date: String?) async throws -> APOD
}

final class GetApodUseCase: GetApodUseCaseProtocol {
    let repository: FetchApodRepositoryProtocol
    
    init(repository: FetchApodRepositoryProtocol) {
        self.repository = repository
    }

    func execute(date: String?) async throws -> APOD {
        try await repository.fetchApod(query: .init(date: date))
    }
}
