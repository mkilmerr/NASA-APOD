//
//  AstroView+Factory.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

extension AstroView {
    static func make() -> AstroView {
        let getAstroRepository = FetchApodRepository(
            networkClient: NetworkClient()
        )

        let getAstroUseCase = GetApodUseCase(
            repository: getAstroRepository
        )
        
        let viewModel = AstroView.ViewModel(
            getAstroUseCase: getAstroUseCase
        )
        
        return AstroView(viewModel: viewModel)
    }
}
