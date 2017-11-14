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
    var sickAtlas = SKTextureAtlas();
    var catAnimation = [SKTexture]();
    var animateCatAction = SKAction();
    var sickAnimation = [SKTexture]();
    var animateSickAction = SKAction();
    
    func initializeCatandAnimations(){
        self.name = "cat"
        self.size = CGSize(width:542.0, height: 474.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -280)
        self.zPosition = 1;
        self.texture = SKTexture(imageNamed: "Cat 1")
        
        sickAtlas = SKTextureAtlas(named: "Sick.atlas")
        walkAtlas = SKTextureAtlas(named: "Walk.atlas")
        
        for i in 1...walkAtlas.textureNames.count {
            let name = "Cat \(i)";
            catAnimation.append(SKTexture(imageNamed: name));
        }
        
        for i in 1...sickAtlas.textureNames.count {
            let name = "Hurt \(i)";
            sickAnimation.append(SKTexture(imageNamed: name));
        }
        
        animateSickAction = SKAction.animate(with: self.sickAnimation, timePerFrame: 0.08, resize: true, restore: false)
        print("The array has \(sickAnimation.count) elements")
        
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
    
    func animateSickCat() {
        self.run(SKAction.repeatForever(animateSickAction), withKey: "AnimateSickCat")
//        self.texture = sickAtlas.textureNamed("Hurt 3")
        print("animateSickCat")
    }
    
    func stopCatAnimation() {
        self.removeAction(forKey: "AnimateCat")
    }
    
    func stopSickCatAnimation() {
        self.removeAction(forKey: "AnimateSickCat")
        self.texture = SKTexture(imageNamed: "Cat 1")
    }
  
    func flipCat() {
        let flip = SKAction.rotate(toAngle:CGFloat(-Double.pi*2),duration:0.5)
        self.run(flip)
    }
}
