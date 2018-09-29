//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTest: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var arya: Person!

    override func setUp() {
        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse, image: UIImage())
        arya = Person(name: "Arya", house: starkHouse, image: UIImage())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Arya Stark")
    }
    
    func testPersonEquality() {
        //1. Identidad
        XCTAssertEqual(ned, ned)
        
        //2. Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse, image: UIImage())
        XCTAssertEqual(eddard, ned)
        
        //3. Desigualdad
        XCTAssertNotEqual(ned, arya)
    }

    func testPersonComparison() {
        XCTAssertGreaterThan(ned, arya)
    }
    
}
