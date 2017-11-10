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
    lazy var egg = self.viewController.gameManager.egg
 
    func initialize() {
    }
    
    override func didMove(to view: SKView) {
        
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

        for touch in touches {
            
            let location = touch.location(in: self);
            
            if atPoint(location).name == "visualEggInstance"{
                print("You touched an egg")
                print(egg.helpEgg(item: "Hat"))
                print(egg.temp)
                eggSprite.crack()
                
    
            }
            
        }
    }
    
    

    
    
    
}
