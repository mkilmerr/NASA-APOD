//
//  Astro.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class Astro {
    let id: UUID = UUID()
    let date: String
    let about: String
    var mediaType: MediaType
    let title: String
    let url: String

    init(
        date: String,
        about: String,
        mediaType: MediaType,
        title: String,
        url: String
    ) {
        self.date = date
        self.about = about
        self.mediaType = mediaType
        self.title = title
        self.url = url
    }
}
