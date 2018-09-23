//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by CRISTIAN ESPES on 23/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season1: Season!
    var episode1: Episode!
    var episode2: Episode!
    var episode3: Episode!
    
    var season2: Season!
    var episode_1: Episode!
    var episode_2: Episode!
    var episode_3: Episode!

    override func setUp() {
        
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
        
        season1 = Season(number: 1, releaseDate: date1, image: UIImage())
        
        episode1 = Episode(number: 1, title: "Winter Is Coming", issueDate: date1, summary: "", season: season1)
        episode2 = Episode(number: 2, title: "The Kingsroad", issueDate: date2, summary: "", season: season1)
        episode3 = Episode(number: 3, title: "Lord Snow", issueDate: date3, summary: "", season: season1)
        
        dateString = "04/01/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date_1 = dateFromString!
        
        dateString = "04/08/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date_2 = dateFromString!
        
        dateString = "05/15/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date_3 = dateFromString!
        
        season2 = Season(number: 2, releaseDate: date_1, image: UIImage())
        
        episode_1 = Episode(number: 1, title: "The North Remembers", issueDate: date_1, summary: "", season: season2)
        episode_2 = Episode(number: 2, title: "The Night Lands", issueDate: date_2, summary: "", season: season2)
        episode_3 = Episode(number: 3, title: "What Is Dead May Never Die", issueDate: date_3, summary: "", season: season2)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
        XCTAssertNotNil(episode3)
        XCTAssertNotNil(episode_1)
        XCTAssertNotNil(episode_2)
        XCTAssertNotNil(episode_3)
    }
    
    // Given - When - Then
    func testSeason_AddEpisodes_ReturnsTheCorrectCountOfEpisodes() {
        XCTAssertEqual(season1.count, 0)
        season1.add(episode: episode1)
        season1.add(episode: episode1)
        season1.add(episode: episode1)
        
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode2)
        XCTAssertEqual(season1.count, 2)
        
        XCTAssertEqual(season2.count, 0)
        season2.add(episode: episode_1)
        
        XCTAssertEqual(season2.count, 1)
        
        season1.add(episode: episode_2)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testEpisode_AddEpisodesVariadic_ReturnsTheCorrectCountOfEpisodes() {
        XCTAssertEqual(season1.count, 0)
        season1.add(episodes: episode1, episode2, episode_3)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testSeasonEquality() {
        // 1. Identidad
        XCTAssertEqual(season1, season1)
        
        // 2. Igualdad
        let dateString = "04/17/2011"
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM/dd/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let dateFromString = dateStringFormatter.date(from: dateString)
        let date1 = dateFromString!
        
        let firstSeason = Season(number: 1, releaseDate: date1, image: UIImage())
        XCTAssertEqual(firstSeason, season1)
        
        // 3. Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(season1, season2)
    }

    func testPersonDescrition() {
        XCTAssertEqual(season1.description, "Season: Season 1, date of release: 2011-04-17 00:00:00 +0000 and number of episodes: 0")
        XCTAssertEqual(season2.description, "Season: Season 2, date of release: 2012-04-01 00:00:00 +0000 and number of episodes: 0")
    }
    
}
