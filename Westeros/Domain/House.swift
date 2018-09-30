//
//  House.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    let name : String
    let sigil : Sigil
    let words : Words
    let wikiUrl: URL
    private var _members: Members
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiUrl = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard self == person.house else { return }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
        /* for person in persons {
            add(person: person)
         }*/
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name)\(words)"
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House {
    var proxyForComparison: String {
        return "\(name)".lowercased()
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    // Como ya tiene implementado el protocolo Equatable, no tenemos que añadir la función <=, la coje de ese protocolo
}
