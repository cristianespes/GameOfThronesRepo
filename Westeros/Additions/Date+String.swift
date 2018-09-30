//
//  Date+String.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

extension String {
    func formatterDateFromString() -> Date {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM/dd/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        return dateStringFormatter.date(from: self)!
    }
}
