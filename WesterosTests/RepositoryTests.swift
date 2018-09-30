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
    var localSeasons: [Season]!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 5)
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
        
        let lannister = Repository.local.house(named: .Lannister)
        XCTAssertEqual(lannister?.name, Family.Lannister.rawValue)
    }

    func testLocalRepositoryHouseFiltering() {
//        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        var filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
        
        filtered = Repository.local.houses { $0.name == "Stark" }
        XCTAssertEqual(filtered[0].count, 3)
    }
    
    func testLocalRepositorySeasonCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
        XCTAssertGreaterThan(localSeasons.count, 0)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositorySeasonFiltering() {
        var filtered = Repository.local.seasons { $0.count == 10 }
        XCTAssertEqual(filtered.count, 6)
        
        filtered = Repository.local.seasons { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
        
        filtered = Repository.local.seasons { $0.name == "Season 1" }
        XCTAssertEqual(filtered[0].count, 10)
    }
}
