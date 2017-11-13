//
//  Cat.swift
//  Tamagotchi
//
//  Created by Sunali Seth on 13/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import SpriteKit

class Cat: SKSpriteNode {
    var walkAtlas = SKTextureAtlas();
    var catAnimation = [SKTexture]();
    var animateCatAction = SKAction();
    
    func initializeCatandAnimations(){
        self.name = "cat"
        self.size = CGSize(width:542.0, height: 474.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -280)
        self.zPosition = 1;
        self.texture = SKTexture(imageNamed: "Cat 1")
        
        walkAtlas = SKTextureAtlas(named: "Walk.atlas")
        for i in 1...walkAtlas.textureNames.count {
            let name = "Cat \(i)";
            catAnimation.append(SKTexture(imageNamed: name));
        }
        animateCatAction = SKAction.animate(with: self.catAnimation, timePerFrame: 0.08, resize: true, restore: false)
        print("The array has \(catAnimation[0]) elements")
    }
    func animateCat(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale);
        } else {
            self.xScale = fabs(self.xScale);
        }
        
        self.run(SKAction.repeatForever(animateCatAction), withKey: "AnimateCat")
        print("animateCat")
    }
    
    func stopCatAnimation() {
        self.removeAction(forKey: "AnimateCat")
    }
  
    func moveCat(moveLeft: Bool) {
        if moveLeft {
            self.position.x -= 7;
        } else {
            self.position.x += 7;
        }
    }
 
}
