//
//  Date+Extension.swift
//  MovieProject
//
//  Created by 여성은 on 6/9/24.
//

import Foundation

extension Date {
    static func boxofficeDate() -> String {
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyyMMdd"
            let converDate = dateformatter.string(from: yesterday)
            print(converDate)
            return converDate
        }
        return ""
    }
}
