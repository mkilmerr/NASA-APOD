//
//  Astro.swift
//  NASA APOD
//
//  Created by longarinas on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class Astro: Equatable {
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

extension Astro {
    public static func == (lhs: Astro, rhs: Astro) -> Bool {
        return lhs.date == rhs.date &&
               lhs.about == rhs.about &&
               lhs.mediaType == rhs.mediaType &&
               lhs.title == rhs.title &&
               lhs.url == rhs.url
    }
}
