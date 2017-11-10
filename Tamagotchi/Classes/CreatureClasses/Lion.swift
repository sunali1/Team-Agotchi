//
//  Lion.swift
//  Tamagotchi
//
//  Created by James Hughes on 10/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation

class Lion {
    
    var size: Int
    var age: Int
    var temp: Int
    var hungry: Bool
    var bursting: Bool
    var stomachContents: [String] = []
    var awake: Bool
    let now = NSDate()
    
    init(size: Int, age: Int, temp: Int, hungry: Bool, bursting: Bool) {
        self.size = size;
        self.age = age;
        self.temp = temp;
        self.hungry = true;
        self.bursting = false;
        self.awake = true;
    }
    
    
    func eat(meal: String) -> String {
       stomachContents.append(meal)
        print(stomachContents)
    }
    
    func hungerStatus() -> String {
        if stomachContents.count <= 1 {
            return "I am hungry!"
        } else if stomachContents.count == 3 {
            return "I am full!"
        } else {
            return ""
        }
    }
    
    func timeTracker(time: Int) -> Int {
        
    }
    
    func awakeStatus() -> String {
        if awake == true {
            return "waaaa i'm tired"
            // take a time argument (based on actual time, and converted for our unit of time, and then let the player
            // know that the lion needs to sleep, or
            // does not need to sleep. depening on when it
            // last had a sleep.
            // depends on the age on the lion.
            // perhaps use a hash, key day, value sleep or nil.
        }
    }
    
    func sleep() {
        // if time creature has been awake for 4 'hours', it needs to sleep, and this makes it sleep.
        // will sleep for a set time.
    }
    
}
