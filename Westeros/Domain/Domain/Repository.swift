//
//  Repository.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 12/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    
    func house(named: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

final class LocalFactory: HouseFactory {
    
    var houses : [House] {
        
        // Houses creation here
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "codeIsComing")!)
        let lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage(named: "lannister.jpg")!)
        let targaryenSigil = Sigil(description: "Dragon Tricefalo", image: UIImage(named: "targaryenSmall.jpg")!)
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: targaryenUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matareyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(persons: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        //return houses.filter { $0.name.lowercased() == name.lowercased() }.first
        //return houses.first(where: { $0.name.lowercased() == name.lowercased() })
        return houses.first{ $0.name.lowercased() == name.lowercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}
