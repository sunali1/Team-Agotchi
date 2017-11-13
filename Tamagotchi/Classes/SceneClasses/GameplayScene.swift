//
//  GameplayScene.swift
//  Tamagotchi
//
//  Created by Sunali Seth on 08/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var eggTexture = SKTexture();
    var canMove = false;
    var moveLeft = false;
    var center = CGFloat();
    let eggSprite = VisualEgg();
    var lionSprite = VisualLion();
    var cat = Cat();
    var pooArray: [VisualPoo] = []
    var viewController: GameViewController!
    lazy var egg = self.viewController.gameManager.egg
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0;
        self.physicsBody?.categoryBitMask = ColliderType.World;
        self.physicsBody = sceneBody
        addChild(eggSprite);
        eggSprite.initialize()
        print("2+2=5 is \(egg.cracked)")
        print(egg.cracked)
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
        }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
        cat.stopCatAnimation()
    }

    
    
    func hatchLion(){
        self.viewController.gameManager.lion = Lion(size: 10, age: 6, temp: 15, hungry: true, bursting: false)
    }

    func crackEgg(){
        if egg.cracked == true {
            return print("Egg already cracked")
        }
        eggSprite.crack(innerFunction: { self.addChild(self.cat)
            self.cat.initializeCatandAnimations();
        })
        egg.cracked = true
        print(egg.cracked)
        self.viewController.hideEggUI()
        self.viewController.feedVisual.isHidden = false
    }
    func manageCat() {
        if canMove{
        cat.moveCat(moveLeft: moveLeft)
        }
    }
    
    func pooQuery() {
        let pooSprite = VisualPoo()
        pooArray.append(pooSprite)
        addChild(pooSprite)
        pooSprite.initialize(name:"Robin Collins", position: cat.position)
        print(pooArray)
        self.viewController.meals.text = "\(self.viewController.gameManager.lion.stomachContents.count)"
    }

}
