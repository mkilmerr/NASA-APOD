//
//  FavoriteRowView+ViewModel.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation

extension FavoriteRowView {
    final class ViewModel: ObservableObject {
        @Published var didSelect: Bool = false
        @Published var didSelectSeeMore: Bool = false

        let astro: Astro
        
        init(astro: Astro) {
            self.astro = astro
        }
        
        var seeMoreUrl: String {
            "https://www.google.com/search?q=\(astro.title)"
        }
    }
}
 
