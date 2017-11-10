//
//  GameplayScene.swift
//  Tamagotchi
//
//  Created by Sunali Seth on 08/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var eggTexture = SKTexture();
    let eggSprite = VisualEgg();
    var viewController: GameViewController!
 
    func initialize() {
    }
    
    override func didMove(to view: SKView) {
        
        let egg = self.viewController.gameManager.egg
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0;
        self.physicsBody?.categoryBitMask = ColliderType.World;
        self.physicsBody = sceneBody

        addChild(eggSprite);
        
        print("2+2=5 is \(egg.cracked)")
        
        eggSprite.initialize();

        print(egg.cracked)
        initialize()
    }
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let egg = self.viewController.gameManager.egg

        for touch in touches {
            
            let location = touch.location(in: self);
            
            if atPoint(location).name == "visualEggInstance"{
                print("You touched an egg")
                eggSprite.jump()
                print(egg.helpEgg(item: "Hat"))
                print(egg.temp)
            }
            
        }
    }

    
    
    
}
