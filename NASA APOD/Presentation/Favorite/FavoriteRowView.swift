//
//  FavoriteRowView.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import SwiftUI

struct FavoriteRowView: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            VStack {
                titleSection()
                if viewModel.didSelect {
                    aboutSection()
                }
            }
        }
        .sheet(isPresented: $viewModel.didSelectSeeMore) {
            WKWebViewRepresentable(urlString: viewModel.seeMoreUrl)
                .presentationDragIndicator(.visible)
        }
    }
    
    private func titleSection() -> some View {
        Button {
            viewModel.didSelect.toggle()
        } label: {
            HStack {
                Text(viewModel.astro.title)
                    .bold()
                    .accessibilityIdentifier("fav_astro_name")
                Spacer()
                Image(systemName: viewModel.didSelect ? "chevron.up": "chevron.down")
                    .contentTransition(.symbolEffect(.replace))
            }
            .padding()
        }
    }
    
    private func aboutSection() -> some View {
        VStack {
            HStack {
                Button {
                    viewModel.didSelectSeeMore.toggle()
                } label: {
                    Text("See more")
                }
                .bold()
                
                Spacer()
            }
            
            Text(viewModel.astro.about)
                .animation(.easeOut, value: viewModel.didSelect)
                .padding(.top, 16)
        }
        .padding()
    }
}

//#Preview {
//    FavoriteRowView()
//}
