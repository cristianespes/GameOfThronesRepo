//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by CRISTIAN ESPES on 22/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var season1: Season!
    var episode1: Episode!
    var episode2: Episode!
    var episode3: Episode!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        var dateString = "04/17/2011"
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM/dd/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        var dateFromString = dateStringFormatter.date(from: dateString)
        let date1 = dateFromString!

        dateString = "04/24/2011"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2 = dateFromString!
        
        dateString = "05/01/2011"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3 = dateFromString!
        
        season1 = Season(number: 1, name: "Season 1", releaseDate: date1)
        
        episode1 = Episode(number: 1, title: "Winter Is Coming", issueDate: date1, season: season1)
        episode2 = Episode(number: 2, title: "The Kingsroad", issueDate: date2, season: season1)
        episode3 = Episode(number: 3, title: "Lord Snow", issueDate: date3, season: season1)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
        XCTAssertNotNil(episode3)
    }
    
    func testPersonDescrition() {
        XCTAssertEqual(episode1.description, "Episode: Winter Is Coming, date of issue: 2011-04-17 00:00:00 +0000 and season: Season 1")
        XCTAssertEqual(episode2.description, "Episode: The Kingsroad, date of issue: 2011-04-24 00:00:00 +0000 and season: Season 1")
        XCTAssertEqual(episode3.description, "Episode: Lord Snow, date of issue: 2011-05-01 00:00:00 +0000 and season: Season 1")
    }
    
    func testEpisodeEquality() {
        //1. Identidad
        XCTAssertEqual(episode1, episode1)
        
        //2. Igualdad
        let dateString = "04/24/2011"
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM/dd/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let dateFromString = dateStringFormatter.date(from: dateString)
        let date2 = dateFromString!
        let newEpisode = Episode(number: 2, title: "The Kingsroad", issueDate: date2, season: season1)
        XCTAssertEqual(newEpisode, episode2)
        
        //3. Desigualdad
        XCTAssertNotEqual(episode1, episode2)
    }
    
    func testEpisodeComparison() {
        XCTAssertGreaterThan(episode2, episode1)
        XCTAssertLessThan(episode1, episode3)
    }
    
    

}
