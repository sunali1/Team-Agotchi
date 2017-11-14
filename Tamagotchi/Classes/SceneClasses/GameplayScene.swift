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
    let catSprite = Cat()
    var pooArray: [VisualPoo] = []
    var pooCounter = 0;
    var viewController: GameViewController!
    lazy var egg = self.viewController.gameManager.egg
//    lazy var cat = self.viewController.gameManager.cat
    let crackSound = SKAction.playSoundFileNamed("Fly.mp3", waitForCompletion: false)
    

    func initialize() {
    }

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

 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewController.gameManager.lion.alive == true{
            for touch in touches {
                let location = touch.location(in: self);
                let touchedNode = self.atPoint(location)
                
                if location.x > center{
                   
                    catSprite.animateCat(moveLeft: false)
                    catSprite.position.x += 7
                } else {
                    catSprite.animateCat(moveLeft: true)
                    catSprite.position.x -= 7
                }
    //            canMove = true;
                
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
                
                if touchedNode.name == "MrPoopy"{
                    print("You touched a poo")
                    self.pooArray.first(where:{$0 == touchedNode})?.fadeOut()
                    self.pooCounter -= 1
                    if pooCounter == 0 {
                        self.viewController.thoughtBubbleText.isHidden = true
                        self.viewController.thoughtBubble.isHidden = true
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewController.gameManager.lion.alive == true{
            for touch in touches {
                let location = touch.location(in: self);
                if location.x > center{
                    catSprite.position.x += 7
                } else {
                    catSprite.position.x -= 7
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
        catSprite.stopCatAnimation()
    }

    
    
    func hatchLion(){
        self.viewController.gameManager.lion = Lion(size: 10, age: 6, temp: 15, hungry: true, bursting: false)
    }

    func crackEgg(){
        run(crackSound)
        if egg.cracked == true {
            return print("Egg already cracked")
            
        }
        eggSprite.crack(innerFunction: { self.addChild(self.catSprite)
            self.catSprite.initializeCatandAnimations();
            self.viewController.foodUIHide(bool: false)
            self.viewController.gameManager.lion.born = true
        })
        egg.cracked = true
        print(egg.cracked)
        self.viewController.hideEggUI()
        self.viewController.feedVisual.isHidden = false
    }
    
    func pooQuery() {
        let pooSprite = VisualPoo()
        pooArray.append(pooSprite)
        addChild(pooSprite)
        pooCounter += 1
        pooSprite.initialize(name:"MrPoopy", position: CGPoint(x:catSprite.position.x, y: catSprite.position.y-200))
        print(pooArray)
//        self.viewController.meals.text = "\(self.viewController.gameManager.lion.stomachContents.count)"
    }

}
