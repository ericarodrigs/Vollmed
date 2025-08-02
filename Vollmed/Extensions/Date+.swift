//
//  Date+.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }
}
