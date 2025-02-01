//
//  Date+LocalDate.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

extension Date {
    func toLocalTime() -> Date {
        let timeZoneOffset = TimeZone.current.secondsFromGMT(for: self)
        return self.addingTimeInterval(TimeInterval(timeZoneOffset))
    }
    
    func isGreaterThanCurrent() -> Bool {
        return self > Date()
    }
}
