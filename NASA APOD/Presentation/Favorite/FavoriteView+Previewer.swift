//
//  FavoriteView+Previewer.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation

extension FavoriteView {
    static func preview() -> Self {
        let storageManager = StorageManagerMock()
        let viewModel = ViewModel(storageManager: storageManager)
        return FavoriteView(viewModel: viewModel)
    }
}
