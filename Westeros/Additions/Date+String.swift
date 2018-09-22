//
//  Date+String.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

extension Date {
    
    static func intToDate(month: Int, day: Int, year: Int) -> Date {
        let dateString = "\(month)/\(day)/\(year)"
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let dateFromString = dateStringFormatter.date(from: dateString)
        
        return dateFromString!
    }
    
    func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
}
