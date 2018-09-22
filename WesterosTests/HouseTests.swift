//
//  HouseTests.swift
//  WesterosTests
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import XCTest
// Añadimos acceso a los archivos de mi proyecto
@testable import Westeros // @testable acceder a todo el código incluso si es privado

class HouseTests: XCTestCase {
    
    var starkSigil : Sigil!
    var lannisterSigil : Sigil!
    var starkHouse : House!
    var lannisterHouse : House!
    var arya : Person!
    var robb : Person!
    var tyrion : Person!
    

    override func setUp() {
        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "codeIsComing")!)
        lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage(named: "lannister.jpg")!)
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    // Given - When - Then
    func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        XCTAssertEqual(lannisterHouse.count, 0)
        lannisterHouse.add(person: tyrion)
        
        XCTAssertEqual(lannisterHouse.count, 1)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouse_AddPersonsVariadic_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(persons: robb, arya, tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseEquality() {
        // 1. Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // 2. Igualdad
        let jinxedHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        XCTAssertEqual(jinxedHouse, starkHouse)
        
        // 3. Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
}
