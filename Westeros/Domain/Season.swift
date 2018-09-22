//
//  Season.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    let number: Int
    let name: String
    let releaseDate: Date
    let episodes : Episodes?
    
    init(number: Int, name: String, releaseDate: Date) {
        self.number = number
        self.name = name
        self.releaseDate = releaseDate
        self.episodes = Episodes()
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(number)\(name)\(releaseDate)"
    }
    
    var proxyForComparison: String {
        return "\(number)\(name)".lowercased()
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
extension Season: CustomStringConvertible {
    var description: String {
        return "Season: \(name), date of release: \(releaseDate) and number of episodes: \(episodes!.count)"
    }
}
