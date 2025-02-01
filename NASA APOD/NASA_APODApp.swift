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
                        Text("Astros")
                        Image(systemName: "moonphase.waxing.gibbous.inverse")
                    }
                
                FavoriteView.make()
                    .tabItem {
                        Text("Favorites")
                        Image(systemName: "star.circle")
                    }
            }
        }
        .modelContainer(for: Astro.self)
    }
}
