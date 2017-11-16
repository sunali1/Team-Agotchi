//
//  Angel.swift
//  Tamagotchi
//
//  Created by Sunali Seth on 15/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import SpriteKit


class Angel: SKSpriteNode {
    
    func initialize() {
        self.name = "angel"
        self.size = CGSize(width:200.0, height: 150.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: -30, y: 320)
        self.zPosition = 2;
        self.texture = SKTexture(imageNamed: "santa")
        print("found an angel")
        self.isHidden = true
    }
}
