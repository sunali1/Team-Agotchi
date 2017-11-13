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
    
    var canMove = false;
    var moveLeft = false;
    var center = CGFloat();
    var temperatureBtn = SKSpriteNode();
    let eggSprite = VisualEgg();
    let hatSprite = Hat();  
    var lionSprite = VisualLion();
    var cat = Cat();
    var viewController: GameViewController!
//    lazy var lion = self.viewController.gameManager.lion
    lazy var egg = self.viewController.gameManager.egg
    
    func initialize() {
        createTemperatureBtn()
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0;
        self.physicsBody?.categoryBitMask = ColliderType.World;
        self.physicsBody = sceneBody

        addChild(eggSprite);
        addChild(hatSprite);
        addChild(cat)
        eggSprite.initialize();
        hatSprite.initialize();
       
        
        print("2+2=5 is \(egg.cracked)")

        print(egg.cracked)
        initialize()
        cat.initializeCatandAnimations()
        center = CGFloat((self.scene?.size.width)!) / CGFloat((self.scene?.size.height)!)
    }
    override func update(_ currentTime: TimeInterval){
        manageCat();
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self);
            
            if location.x > center{
                moveLeft = false;
                cat.animateCat(moveLeft: moveLeft)
            } else {
                moveLeft = true;
                cat.animateCat(moveLeft: moveLeft)
            }
            canMove = true;
            
//            if atPoint(location).name == "visualLionInstance"{
//                print("You touched a Lion")
//                lionSprite.jump()
//            }
            
            if atPoint(location).name == "visualEggInstance"{
                print("You touched an egg")
                print(egg.helpEgg(item: "Hat"))
                print(egg.temp)
                if egg.temp > 18 {
                    crackEgg()
                    hatchLion()
                    print(self.viewController.gameManager.lion.temp)
                }
            }
            if atPoint(location).name == "temperature" {
                print("You touched temp")
                incrementTemperature()
                print(egg.temp)
            }
            
            if atPoint(location).name == "Hat"{
                print("You touched the hat")
                let location = touch.location(in: self)
                if hatSprite.contains(location) {
                    hatSprite.position = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            if atPoint(location).name == "Hat"{
                let touch = touches.first
                hatSprite.position = (touch?.location(in:self))!
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         for touch in touches {
             let location = touch.location(in: self);
            if atPoint(location).name == "Hat"{
                hatSprite.position = (touch.location(in:self))
            }
        }
        canMove = false;
        cat.stopCatAnimation()
    }
    
    
    func hatchLion(){
        self.viewController.gameManager.lion = Lion(size: 10, age: 6, temp: 15, hungry: true, bursting: false)
    }

    func crackEgg(){
        eggSprite.crack(innerFunction: { self.addChild(self.lionSprite)
            self.lionSprite.initialize();
        })
        egg.cracked = true
        print(egg.cracked)
    }
    func manageCat() {
        if canMove{
        cat.moveCat(moveLeft: moveLeft)
        }
    }
    
//    func manageLionSprite() {
//        if canMove{
//            lionSprite.moveVisualLion(moveLeft: moveLeft);
//        }
//    }
    
    func createTemperatureBtn() {
        
//        let temperatureBtn = SKSpriteNode(imageNamed: "Pause Menu")
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
