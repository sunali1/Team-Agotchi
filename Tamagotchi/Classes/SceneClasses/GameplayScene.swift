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
    var creature = SKSpriteNode()
    var temperatureBtn = SKSpriteNode();
    let eggSprite = VisualEgg();
    var viewController: GameViewController!
    lazy var egg = self.viewController.gameManager.egg
 
    func initialize() {
        createTemperatureBtn()
        createCreature()
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
                if egg.temp > 18 {
                   eggSprite.crack()
                    egg.cracked = true
                    print(egg.cracked)
                }
            }
            if atPoint(location).name == "temperature" {
                print("You touched temp")
                incrementTemperature()
                print(egg.temp)
            }
        }
    }
    
    func createCreature() {
        let creature = SKSpriteNode(imageNamed: "Blue 1")
        creature.name = "Trump";
        creature.zPosition = 1
        creature.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        creature.position = CGPoint(x: 0, y: 0);
        creature.size = CGSize(width: 100, height: 100);
        self.addChild(creature);
    }
    
    func createTemperatureBtn() {
        
        let temperatureBtn = SKSpriteNode(imageNamed: "Pause Menu")
        temperatureBtn.name = "temperature"
        temperatureBtn.zPosition = 6;
        temperatureBtn.position = CGPoint(x: 0, y: 450);
        
        //        temperatureBtn.text = "- 10°C +";
        //        temperatureLabel.fontColor = SKColor colorWithRed:0.1
        self.addChild(temperatureBtn);
    }
    func incrementTemperature() {
        egg.temp = egg.temp + 1
        
    }
}
