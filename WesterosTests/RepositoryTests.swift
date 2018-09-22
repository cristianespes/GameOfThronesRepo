//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by CRISTIAN ESPES on 12/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localHouses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
        XCTAssertGreaterThan(localHouses.count, 0)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "StaRk")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "KeePCOding")
        XCTAssertNil(keepcoding)
    }

    func testLocalRepositoryHouseFiltering_() {
//        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        var filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
        
        filtered = Repository.local.houses { $0.name == "Stark" }
        XCTAssertEqual(filtered[0].count, 2)
    }
}
