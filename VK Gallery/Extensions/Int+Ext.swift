//
//  Int+Ext.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 03.10.2025.
//

import Foundation

extension Int {
    func convertToStringDateFromTimestamp() -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM, yyyy"
        
        return dateFormatter.string(from: date)
    }
}
