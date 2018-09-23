//
//  Season.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation
import UIKit

typealias Episodes = Set<Episode>

final class Season {
    
    let number: Int
    
    var name : String {
        return "Season \(number)"
    }
    
    let releaseDate: Date
    let image: UIImage
    
    private var _episodes: Episodes
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    init(number: Int, releaseDate: Date, image: UIImage) {
        self.number = number
        self.releaseDate = releaseDate
        self.image = image
        _episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    func add(episode: Episode) {
        guard self == episode.season else { return }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
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
        return "Season: \(name), date of release: \(releaseDate) and number of episodes: \(count)"
    }
}
