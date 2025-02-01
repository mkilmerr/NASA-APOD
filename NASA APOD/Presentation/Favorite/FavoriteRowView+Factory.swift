//
//  FavoriteRowView+Factory.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation

extension FavoriteRowView {
    static func make(with astro: Astro) -> Self {
        let viewModel = FavoriteRowView.ViewModel(astro: astro)
        return .init(viewModel: viewModel)
    }
}
