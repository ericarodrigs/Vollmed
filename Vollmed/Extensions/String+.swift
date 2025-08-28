//
//  String+.swift
//  Vollmed
//
//  Created by Erica Rodrigues on 02/08/25.
//

import Foundation

extension String {
    func convertDateStringToReadableDate() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else {
            return nil
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        displayFormatter.locale = Locale(identifier: "pt_BR")
        displayFormatter.timeZone = TimeZone.current
        
        return displayFormatter.string(from: date)
    }
}
