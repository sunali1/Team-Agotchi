//
//  Cat.swift
//  Tamagotchi
//
//  Created by Sunali Seth on 13/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import SpriteKit

class Cat: SKSpriteNode {
    var idleFlag = true;
    var walkAtlas = SKTextureAtlas();
    var sickAtlas = SKTextureAtlas();
    var deadAtlas = SKTextureAtlas();
    var idleAtlas = SKTextureAtlas();
    var catAnimation = [SKTexture]();
    var sickAnimation = [SKTexture]();
    var deadAnimation = [SKTexture]();
    var idleAnimation = [SKTexture]();
    var animateCatAction = SKAction();
    var animateSickAction = SKAction();
    var animateDeadAction = SKAction();
    let deadSound = SKAction.playSoundFileNamed("Dead.mp3", waitForCompletion: false)
    var animateIdleAction = SKAction();
    
    
    func initializeCatandAnimations(){
        self.name = "cat"
        self.size = CGSize(width:542.0, height: 474.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: 0, y: -280)
        self.zPosition = 1;
        self.texture = SKTexture(imageNamed: "Cat 1")
        
        sickAtlas = SKTextureAtlas(named: "Sick.atlas")
        walkAtlas = SKTextureAtlas(named: "Walk.atlas")
        deadAtlas = SKTextureAtlas(named: "Dood.atlas")
        idleAtlas = SKTextureAtlas(named: "Idle.atlas")
        
        for i in 1...walkAtlas.textureNames.count {
            let name = "Cat \(i)";
            catAnimation.append(SKTexture(imageNamed: name));
        }
        
        for i in 1...sickAtlas.textureNames.count {
            let name = "Hurt \(i)";
            sickAnimation.append(SKTexture(imageNamed: name));
        }
        
        for i in 1...deadAtlas.textureNames.count {
            let name = "Dead \(i)";
            deadAnimation.append(SKTexture(imageNamed: name));
        }
        
        for i in 1...idleAtlas.textureNames.count {
            let name = "Idle \(i)";
            idleAnimation.append(SKTexture(imageNamed: name));
        }
        
        animateSickAction = SKAction.animate(with: self.sickAnimation, timePerFrame: 0.10, resize: true, restore: false)
        print("The array has \(sickAnimation.count) elements")
        
        animateCatAction = SKAction.animate(with: self.catAnimation, timePerFrame: 0.08, resize: true, restore: false)
        print("The array has \(catAnimation[0]) elements")
        
        animateDeadAction = SKAction.animate(with: self.deadAnimation, timePerFrame: 0.08, resize: true, restore: false)
        print("The array has \(deadAnimation.count) elements")
        
        animateIdleAction = SKAction.animate(with: self.idleAnimation, timePerFrame: 0.16, resize: true, restore: false)
        print("The Idle array has \(idleAnimation.count) elements")
    }

    func animateCat(moveLeft: Bool){
        if moveLeft {
            self.xScale = -fabs(self.xScale);
        } else {
            self.xScale = fabs(self.xScale);
        }
        
        self.run(SKAction.repeatForever(animateCatAction), withKey: "AnimateCat")
        print("animateCat")
    }
    
    func animateSickCat(){
        self.run(SKAction.repeatForever(animateSickAction), withKey: "AnimateSickCat")
        print("animateSickCat")
    }
    
    func animateDeadCat() {
        self.removeAllActions()
        self.run(animateDeadAction, withKey: "AnimateDeadCat")
        run(deadSound)
        print("animateDeadCat")
    }
    
    func stopCatAnimation() {
        self.removeAction(forKey: "AnimateCat")
    }
    
    func stopSickCatAnimation() {
        self.removeAction(forKey: "AnimateSickCat")
        self.texture = SKTexture(imageNamed: "Cat 1")
        idleFlag = true
        self.startIdleAnimation()
    }
    
    func stopDeadCatAnimation() {
        self.removeAction(forKey: "AnimateDeadCat")
        self.texture = SKTexture(imageNamed: "Dead 10")
    }
  
    func flipCat(innerFunction:@escaping()->Void) {
        let flip = SKAction.rotate(byAngle:CGFloat(Double.pi*2),duration:0.5)
        self.run(flip){ innerFunction() }
    }
    
    func startIdleAnimation(){
        if idleFlag == true {
        print("And go and go")
        self.run(SKAction.repeatForever(animateIdleAction), withKey: "IdleAction")
        }
    }
}
