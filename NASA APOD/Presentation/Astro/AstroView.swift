//
//  AstroView.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI

struct AstroView: View {
    @StateObject private var viewModel: AstroView.ViewModel
    let videoURL = "https://www.youtube.com/embed/7QB_MOemCqs?rel=0"

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
        .task {
            await viewModel.loadAstro()
        }
    }
    
    
    private func loadAstro(_ date: Date) {
        Task {
            await viewModel.loadAstro(with: date)
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
            Text(viewModel.astro?.title ?? "")
                .font(.headline)
            Text(viewModel.astro?.date ?? "")
          
        }
        .padding()
    }
    
    private func mediaContent() -> some View {
        VStack {
            if let astro = viewModel.astro {
                switch astro.mediaType {
                case .video:
                    WKWebViewRepresentable(videoURL: astro.url)
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
            Text(viewModel.astro?.explanation ?? "")
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
    }
}

//#Preview {
//    AstroView()
//}
