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
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? .now
    }
}
