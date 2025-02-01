//
//  FavoriteView+ViewModel.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation
import SwiftData

extension FavoriteView {
    final class ViewModel: ObservableObject {
        @Published private(set) var favorites: [Astro] = []
        
        @MainActor
        func loadFavoriteAstros(
            context: ModelContext,
            descriptor: FetchDescriptor<Astro>
        ) {
            let storage: StorageParameters<Astro> = (context: context, descriptor: descriptor)
            favorites = StorageManager().getAll(storage: storage)
        }
    }
}
