//
//  Character.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: - Properties
    let name : String
    let house : House
    private let _alias : String?
    
    var alias: String {
        get {
//            if let alias = _alias {
//                // Existe y está guardado dentro de alias
//                return alias
//            } else {
//                return ""
//            }
            return _alias ?? ""
        }
    }
    
    // MARK: - Initialization
    init(name: String, alias: String, house: House) {
        self.name = name
        _alias = alias
        self.house = house
    }
    
    init(name: String, house: House) {
        self.name = name
        self.house = house
        _alias = nil
    }
}
