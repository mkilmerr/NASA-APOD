//
//  FavoriteView.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @StateObject private var viewModel: ViewModel
    @Environment(\.modelContext) private var context
    let fetchDescriptor = FetchDescriptor<Astro>()
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
           VStack {
               if viewModel.showEmptyMessage {
                   emptyMessage()
               } else {
                   favoriteList()
               }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.loadFavoriteAstros(
                    context: context,
                    descriptor: fetchDescriptor
                )
            }
        }
    }
    
    private func emptyMessage() -> some View {
        VStack {
            Spacer()
            HStack {
                Text("You don't have favorites yet :(")
                Image(systemName: "moon.zzz")
            }
            .bold()
            Spacer()
        }
    }
    
    private func favoriteList() -> some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.favorites) { astro in
                    FavoriteRowView.make(with: astro)
                }
            }
        }
    }
}

#Preview {
    FavoriteView.make()
}
