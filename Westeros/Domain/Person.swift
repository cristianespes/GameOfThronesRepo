//
//  Character.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

final class Person {
    
    // MARK: - Properties
    let name : String
    let house : House
    let image : UIImage
    private let _alias : String?
    
    var alias: String {
        get {
            return _alias ?? ""
        }
    }
    
    // MARK: - Initialization
    init(name: String, alias: String? = nil, house: House, image: UIImage) {
        self.name = name
        _alias = alias
        self.house = house
        self.image = image
        
        self.house.add(person: self)
    }
    
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
}

extension Person {
    var fullName : String {
        return "\(self.name) \(self.house.name)"
    }
}

extension Person {
    var proxy : String { // Identificar inequivocamente una persona
        return "\(name)\(alias)\(house.name)"
    }
    
    var proxyForComparison : String { // Ordenar según un criterio, nombre, fecha, etc
        return fullName.lowercased()
    }
}

extension Person : Hashable {
    var hashValue: Int {
        
        return proxy.hashValue
    }
}

extension Person : Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

extension Person : Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
