//
//  AstroView+Previewer.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation

extension AstroView {
    static func preview() -> Self {
        let viewModel = AstroView.ViewModel(
            getAstroUseCase: GetApodUseCasePreviewer(),
            storageManager: StorageManagerMock()
        )
        
        viewModel.date = "2022-10-23".toDate()

        return AstroView(viewModel: viewModel)
    }
}

final class GetApodUseCasePreviewer: GetApodUseCaseProtocol {
    func execute(date: String?) async throws -> APOD {
        APOD(
            copyright: nil,
            date: "2022-10-23",
            explanation: "Preview explanation",
            hdurl: nil,
            mediaType: .image,
            serviceVersion: "Preview service",
            title: "Preview title of an APOD",
            url: "url-preview")
    }
}
