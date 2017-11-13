//
//  VisualLion.swift
//  Tamagotchi
//
//  Created by James Hughes on 10/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import Foundation
import SpriteKit

struct lionColliderType {
    static let Lion: UInt32 = 1;
    static let World: UInt32 = 2;
}

class VisualLion: SKSpriteNode {
    
    
    var lionAnimationAction = SKAction();
    
    func initialize(){
        self.name = "visualLionInstance"
        self.size = CGSize(width:200.0, height: 200.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -280)
        self.zPosition = 1;
        self.texture = SKTexture(imageNamed: "lion.png")
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size);
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = lionColliderType.Lion;
        self.physicsBody?.collisionBitMask = lionColliderType.Lion;
        
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx:0, dy:50)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
    }
    func moveVisualLion(moveLeft: Bool) {
        if moveLeft {
            self.position.x -= 7;
        } else {
            self.position.x += 7;
        }
    }
}

