//
//  AstroView+ViewModel.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation
import SwiftData

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
        @Published private(set) var astro: Astro?
        @Published var isAnimating = false
        @Published var date = Date().toLocalTime()
        @Published var showAlert: Bool = false
        @Published var markAsFavorite: Bool = false

        private let getAstroUseCase: GetApodUseCaseProtocol
        private let storageManager: StorageManagerProtocol

        init(
            getAstroUseCase: GetApodUseCaseProtocol,
            storageManager: StorageManagerProtocol
        ) {
            self.getAstroUseCase = getAstroUseCase
            self.storageManager = storageManager
        }

        var errorMessage: String {
            if viewState == .error(.invalidDate) {
                return "Select a date less than or equal to the current date"
            } else {
                return "Something went wrong!"
            }
        }

        @MainActor
        func loadAstro(with date: Date? = nil, context: ModelContext, descriptor: FetchDescriptor<Astro>) async {
            viewState = .loading
            do {
                astro = try await getAstroUseCase.execute(
                    date: date?.description.separateBySpace()
                ).mapToAstro()
                viewState = .success
                isAnimating.toggle()
                checkIfIsFavorite(
                    context: context,
                    descriptor: descriptor
                )
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
        
        @MainActor
        func favoriteAstro(context: ModelContext, descriptor: FetchDescriptor<Astro>) {
            guard let astro else { return }
            let storage: StorageParameters<Astro> = (context: context, descriptor: descriptor)
            markAsFavorite = storageManager.add(storage: storage, item: astro)
        }
        
        @MainActor
        func checkIfIsFavorite(context: ModelContext, descriptor: FetchDescriptor<Astro>) {
            guard let astro else { return }
            let storage: StorageParameters<Astro> = (context: context, descriptor: descriptor)
            markAsFavorite = storageManager.checkIfItemIsAlreadyAdded(storage: storage, item: astro)
        }
    }
}
