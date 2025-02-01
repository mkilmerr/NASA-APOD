//
//  AstroView.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI
import SwiftData

struct AstroView: View {
    @StateObject private var viewModel: AstroView.ViewModel
    @Environment(\.modelContext) private var context
    let fetchDescriptor = FetchDescriptor<Astro>()
 
    init(viewModel: AstroView.ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                loading()
            case .success, .error(_):
                content()
            }
        }
        .onChange(of: viewModel.date, { oldValue, newValue in
            loadAstro(newValue)
        })
        .alert("Erro", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
        .onViewDidLoad {
            Task {
                await viewModel.loadAstro(
                    context: context,
                    descriptor: fetchDescriptor
                )
            }
        }
    }

    private func loadAstro(_ date: Date) {
        Task {
            await viewModel.loadAstro(
                with: date,
                context: context,
                descriptor: fetchDescriptor
            )
        }
    }

    private func content() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            header()
            footer()
        }
    }
    
    private func loading() -> some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(2.0)
                .padding(.bottom, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func header() -> some View {
        VStack {
            datePicker()
                .padding(.trailing, 4)
            Text("NASA Astronomy Picture Of The Day")
                .font(.largeTitle)
                .bold()
                .padding()
            Text(viewModel.astro?.title ?? "")
                .font(.headline)
            HStack {
                Text(viewModel.astro?.date ?? "")
                Button {
                    viewModel.favoriteAstro(context: context, descriptor: fetchDescriptor)
                } label: {
                    Image(systemName: viewModel.markAsFavorite ? "star.fill" : "star")
                        .tint(.yellow)
                        .contentTransition(.symbolEffect(.replace))
                        .symbolEffect(.bounce.down, value: viewModel.markAsFavorite)
                }
            }
        }
    }
    
    private func mediaContent() -> some View {
        VStack {
            if let astro = viewModel.astro {
                switch astro.mediaType {
                case .video:
                    WKWebViewRepresentable(urlString: astro.url)
                case .image:
                    RemoteImage(url: URL(string: astro.url))
                }
            }
        }
        .frame(height: 350)
    }
    
    private func footer() -> some View {
        VStack(spacing: 16) {
            mediaContent()
            Text(viewModel.astro?.about ?? "")
                .font(.subheadline)
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
    }

    private func datePicker() -> some View {
        DatePicker(
            "Select a date",
            selection: $viewModel.date,
            displayedComponents: [.date]
        )
        .bold()
    }
}

//#Preview {
//    AstroView()
//}
