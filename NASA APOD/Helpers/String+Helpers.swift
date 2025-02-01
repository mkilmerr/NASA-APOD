//
//  String+SeparateBySpace.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

extension String {
    func separateBySpace() -> String {
        components(separatedBy: " ").first ?? ""
    }
}
