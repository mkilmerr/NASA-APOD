//
//  FavoriteView+Factory.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation

extension FavoriteView {
    static func make() -> Self {
        let storageManager = StorageManager()
        let viewModel = FavoriteView.ViewModel(storageManager: storageManager)
        return FavoriteView(viewModel: viewModel)
    }
}
