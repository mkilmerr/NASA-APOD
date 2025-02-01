//
//  AstroView+ViewModel.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI

extension AstroView {
    enum ViewState: Equatable {
        case loading
        case success
        case error(ErrorState)
    }
    
    enum ErrorState: Equatable {
        case invalidDate
        case general
    }
}

extension AstroView {
    final class ViewModel: ObservableObject {
        @Published private(set) var viewState: ViewState = .loading
        @Published private(set) var astro: APOD?
        @Published var isAnimating = false
        @Published var date = Date().toLocalTime()
        @Published var showAlert: Bool = false

        private let getAstroUseCase: GetApodUseCaseProtocol

        init(getAstroUseCase: GetApodUseCaseProtocol) {
            self.getAstroUseCase = getAstroUseCase
        }

        var errorMessage: String {
            if viewState == .error(.invalidDate) {
                return "Select a date less than or equal to the current date"
            } else {
                return "Something went wrong!"
            }
        }

        @MainActor
        func loadAstro(with date: Date? = nil) async {
            viewState = .loading
            do {
                astro = try await getAstroUseCase.execute(
                    date: date?.description.separateBySpace()
                )
                viewState = .success
                isAnimating.toggle()
            } catch {
                setError(with: date)
                showAlert = true
            }
        }

        @MainActor
        private func setError(with date: Date?) {
            guard let date else { return }
            
            if date.isGreaterThanCurrent() {
                viewState = .error(.invalidDate)
                self.date = .now.toLocalTime()
            } else {
                viewState = .error(.general)
            }
        }
    }
}
