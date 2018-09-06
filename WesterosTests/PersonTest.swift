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

    override func setUp() {
        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence() {
        let character = Person(name: "Eddaard", alias: "Ned", house: starkHouse)
        XCTAssertNil(character)
    }

}
