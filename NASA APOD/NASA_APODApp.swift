//
//  NASA_APODApp.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI

@main
struct NASA_APODApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                AstroView.make()
                    .tabItem {
                        Image(systemName: "moonphase.waxing.gibbous.inverse")
                    }
                
                FavoriteView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "star.circle")
                    }
            }
        }
        .modelContainer(for: Astro.self)
    }
}
