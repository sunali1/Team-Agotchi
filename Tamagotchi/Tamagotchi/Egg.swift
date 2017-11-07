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
}
