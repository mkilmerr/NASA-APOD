//
//  APOD.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

struct APOD: Decodable, Equatable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: MediaType
    let serviceVersion: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
    
    
    func mapToAstro() -> Astro {
        .init(
            date: date, 
            about: explanation,
            mediaType: mediaType,
            title: title,
            url: url
        )
    }
}
