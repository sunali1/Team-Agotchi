//
//  background.swift
//  Tamagotchi
//
//  Created by Benjamin on 15/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation
import SpriteKit


class Background: SKSpriteNode {

    func initialize(width: CGFloat, height: CGFloat, img: String? = "Forest BG.png"){
        self.name = "Background"
        self.size.width = width
        self.size.height = height
        self.texture = SKTexture(imageNamed: img!)
        self.position = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 1;
    }
    

}
