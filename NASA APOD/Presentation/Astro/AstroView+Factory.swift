//
//  AstroView+Factory.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

extension AstroView {
    static func make() -> Self {
        let getAstroRepository = FetchApodRepository(
            networkClient: NetworkClient()
        )

        let getAstroUseCase = GetApodUseCase(
            repository: getAstroRepository
        )
        
        let storageManager = StorageManager()
        
        let viewModel = AstroView.ViewModel(
            getAstroUseCase: getAstroUseCase,
            storageManager: storageManager
        )
        
        return AstroView(viewModel: viewModel)
    }
}
