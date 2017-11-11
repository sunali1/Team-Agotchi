//
//  VisualEgg.swift
//  Tamagotchi
//
//  Created by MacBook Pro on 09/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation
import SpriteKit

class Hat: SKSpriteNode {
    
    func initialize(){
        self.name = "Hat"
        self.size = CGSize(width:200.0, height: 200.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 100, y: -280)
        self.zPosition = 4;
        self.texture = SKTexture(imageNamed: "bobbleHatimg.png")
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size);
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.allowsRotation = false;
        
        self.physicsBody?.categoryBitMask = ColliderType.Egg;
        self.physicsBody?.collisionBitMask = ColliderType.Egg;
        self.physicsBody?.collisionBitMask = ColliderType.World;
        
    }

}
