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
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.favorites) { astro in
                    Text(astro.title)
                }
            }
        }
        .onAppear {
            viewModel.loadFavoriteAstros(
                context: context,
                descriptor: fetchDescriptor
            )
        }
    }
}

//#Preview {
//    FavoriteView()
//}
