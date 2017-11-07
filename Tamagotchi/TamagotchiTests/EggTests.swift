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
    let egg = Egg()
    
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
    
}
