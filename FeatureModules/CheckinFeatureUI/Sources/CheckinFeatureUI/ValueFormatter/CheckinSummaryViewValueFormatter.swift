//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import Foundation

public class CheckinSummaryViewValueFormatter {
    private static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        df.timeZone = TimeZone(identifier: "UTC")
        return df
    }()

    static func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
