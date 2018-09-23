//
//  Episode.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

final class Episode {
    let number: Int
    let title: String
    let issueDate: Date
    let summary: String
    weak var season: Season?
    
    init(number: Int, title: String, issueDate: Date, summary: String, season: Season?) {
        self.number = number
        self.title = title
        self.issueDate = issueDate
        self.summary = summary
        self.season = season
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(number)\(title)\(issueDate)\(season!.number)"
    }
    
    var proxyForComparison: String {
        return "\(number)\(season!.number)\(title)".lowercased()
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "Episode: \(title), date of issue: \(issueDate) and season: \(season!.name)"
    }
}
