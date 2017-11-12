//
//  LionTests.swift
//  TamagotchiTests
//
//  Created by ROBIN A COLLINS on 12/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import XCTest
@testable import Tamagotchi

class LionTests: XCTestCase {
    let lion = Lion(size: 10, age: 10, temp: 15, hungry: true, bursting: false)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLionSizeStartsAtTen() {
        XCTAssertTrue(lion.size == 10)
    }
    
    func testLionAgeStartsAtTen() {
        XCTAssertTrue(lion.age == 10)
    }
    
    func testLionTempStartsAtFifteen() {
        XCTAssertTrue(lion.temp == 15)
    }
    
    func testLionHungerStatusStartsHungry() {
//        let result = lion.lionStartsHungry()
        XCTAssertTrue(lion.hungry == true)
    }
    
    func testLionMealsAreStored() {
        let _ = lion.eat(meal: "biltong");
        let _ = lion.eat(meal: "chicken");
        let _ = lion.eat(meal: "fish")
        XCTAssertEqual(lion.stomachContents, (["biltong", "chicken", "fish"]))
    }
    
    
    func testLionCanEat() {
        let result = lion.eat(meal: "biltong")
        XCTAssertEqual(result, "biltong")
    }
    
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
