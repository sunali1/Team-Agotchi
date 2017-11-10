//
//  VisualEgg.swift
//  Tamagotchi
//
//  Created by MacBook Pro on 09/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation
import SpriteKit

struct ColliderType {
    static let Egg: UInt32 = 1;
    static let World: UInt32 = 2;
}

class VisualEgg: SKSpriteNode {
    
    
    var eggAnimationAction = SKAction();
    
    func initialize(){
        self.name = "visualEggInstance"
        self.size = CGSize(width:200.0, height: 200.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -280)
        self.zPosition = 1;
        self.texture = SKTexture(imageNamed: "1276572-200.png")
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size);
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = ColliderType.Egg;
        self.physicsBody?.collisionBitMask = ColliderType.World
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx:0, dy:50)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
        
        
    }
    
    
    
}

