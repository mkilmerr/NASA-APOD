//
//  APOD+Mock.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import Foundation
@testable import NASA_APOD

extension APOD {
    static func mock(
        copyright: String? = "test copyright",
        date: String,
        explanation: String = "test explanation ",
        hdurl: String? = nil,
        mediaType: MediaType = .image,
        serviceVersion: String = "test serviceVersion",
        title: String,
        url: String
    ) -> Self {
        .init(
            copyright: copyright,
            date: date,
            explanation: explanation,
            hdurl: hdurl,
            mediaType: mediaType,
            serviceVersion: serviceVersion,
            title: title,
            url: url
        )
    }
}

