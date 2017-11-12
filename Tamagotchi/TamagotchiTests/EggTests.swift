//
//  EggTests.swift
//  TamagotchiTests
//
//  Created by James Hughes on 07/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import XCTest
@testable import Tamagotchi

class EggTests: XCTestCase {
    let egg = Egg(size: 0, age: 0, temp: 10, cracked: false)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEggSizeStartsAtZero() {
        XCTAssertTrue(egg.size == 0)
    }
    
    func testEggAgeStartsAtZero() {
        XCTAssertTrue(egg.age == 0)
    }
    
    func testEggTempStartsAt10() {
        XCTAssertTrue(egg.temp == 10)
    }
    
    func testEggCrackedStatusStartsAsFalse() {
        let result = egg.isEggCracked()
        XCTAssertEqual(result, false)
    }
    
    func testHelpDaEgg() {
        let result = egg.helpEgg(item: "Hat")
        XCTAssertEqual(result, "Hat warmed up egg by 1 degree")
    }
    
    func testHelpDaEggWithHat() {
        let result = egg.helpEgg(item: "Hat")
        XCTAssertEqual(result, "Hat warmed up egg by 1 degree")
    }
    
    func testHelpDaEggWithFan() {
        let result = egg.helpEgg(item: "Fan")
        XCTAssertEqual(result, "Fan cooled egg by -1 degree")
    }
    
    func testHelpDaEggWithColdLemonade() {
        let result = egg.helpEgg(item: "Cold Lemonade")
        XCTAssertEqual(result, "Cold Lemonade cooled egg by -2 degree")
    }
    
    func testHelpDaEggWithHotWaterBottle() {
        let result = egg.helpEgg(item: "Hot Water Bottle")
        XCTAssertEqual(result, "Hot Water Bottle warmed up egg by 2 degree")
    }
    
    func testCrackDaEgg() {
        let result = egg.crackEgg()
        XCTAssertEqual(result, true)
    }
    
    func testDaEggHatches() {
        let result = egg.hatchEgg(temp: 15, age: 7)
        XCTAssertEqual(result, "The egg has cracked")
    }
    
    func testDaEggDontHatch() {
        let result = egg.hatchEgg(temp: 8, age: 3)
        XCTAssertEqual(result, "Turn up the temperature and be patient")
    }
    
    func testCanIncreaseAge() {
        let _ = egg.increaseAge(day: "Next")
        XCTAssertTrue(egg.age == 1)
    }
    
    func testupdateSize() {
        let _ = egg.updateSize(day: "Next")
        XCTAssertTrue(egg.size == 1)
    }
    
    func testEggCanGrowAndUpdateSize() {
        let _ = egg.grow()
        XCTAssertEqual(egg.size, 1)
    }
    
    func testEggCanGrowAndIncreaseAge() {
        let _ = egg.grow()
        XCTAssertEqual(egg.age, 1)
    }
    
    func testEggCanDie() {
        let result1 = egg.die(temp: 5, age: 4)
        XCTAssertEqual(result1, "Egg has caught hypothermia and died")
        let result2 = egg.die(temp: 35, age: 4)
        XCTAssertEqual(result2, "Egg has overheated and died")
    }
}
