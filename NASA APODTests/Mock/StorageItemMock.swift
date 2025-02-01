//
//  StorageItemMock.swift
//  NASA APODTests
//
//  Created by longarinas on 01/02/25.
//

import SwiftData
@testable import NASA_APOD

@Model
final class StorageItemMock: Equatable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static func == (lhs: StorageItemMock, rhs: StorageItemMock) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}
