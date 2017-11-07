//
//  Egg.swift
//  Tamagotchi
//
//  Created by James Hughes on 07/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation

class Egg {
    
    var size: Int
    var age: Int
    var temp: Int
    var cracked: Bool
    
    init() {
        size = 0
        age = 0
        temp = 10
        cracked = false
    }
    
    func isEggCracked() -> Bool {
        return cracked
    }
    
    func updateTemp(item: String) -> Int {
        if item == "Hat" {
            temp += 1
            return 1
        }
        else if item == "Hot Water Bottle" {
            temp += 2
            return 2
        }
        else if item == "Fan" {
            temp -= 1
            return -1
        }
        else if item == "Cold Lemonade" {
            temp -= 2
            return -2
        } else {
            return temp
        }
    }
    
    func helpEgg(item: String) -> String {
        let result = self.updateTemp(item: item)
        if result > 0 {
            return "\(item) warmed up egg by \(result) degree"
        } else if result < 0 {
            return "\(item) cooled egg by \(result) degree"
        } else {
            return ""
        }
    }
}


