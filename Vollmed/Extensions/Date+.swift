//
//  Date+.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSSZ"
        return dateFormatter.string(from: self)
    }
}
