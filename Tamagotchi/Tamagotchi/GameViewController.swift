//
//  GameViewController.swift
//  Tamagotchi
//
//  Created by James Hughes on 07/11/2017.
//  Copyright © 2017 Tammo Team. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    let gameManager = GameManager()

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var thermometer: UIImageView!

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var IceCreamOne: UIImageView!
    @IBOutlet weak var IceCreamTwo: UIImageView!
    @IBOutlet weak var IceCreamThree: UIImageView!
    @IBOutlet weak var touchHatVisual: UIButton!
    @IBOutlet weak var poopVisual: UIButton!
    @IBOutlet weak var feedVisual: UIButton!
    
    @IBOutlet weak var thoughtBubbleText: UITextView!
    @IBOutlet weak var thoughtBubble: UIImageView!
    @IBOutlet weak var happiness: UILabel!
    

    var age = 0
    var hungryDays = 0
    var playDays = 0
    var ageActivated = true
    var ageTracker = Timer()
    var foodTracker = Timer()
    var scene = GameplayScene(fileNamed: "GameplayScene")

    @IBAction func touchHatButton(_ sender: Any) {
        gameManager.egg.wearingHat = true
        updateTempLabel()
        resizeRetextureEggToHatEgg()
        self.touchHatVisual.isHidden = true
    }
    @IBAction func wake(_ sender: UIButton) {

        if ageActivated == true{
            return print("Age already active")
        }
        ageTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateAge)), userInfo: nil, repeats: true)    //runs updateAge function once every 1 seconds. So one minute in time equals 1 day in age
        ageActivated = true
    }


    @IBAction func sleep(_ sender: UIButton) {
        ageTracker.invalidate()
        ageActivated = false
    }

    @IBAction func poo(_ sender: Any) {
        gameManager.lion.pooNow()
        fillIceCreamArray()
        scene?.pooQuery()
        self.poopVisual.isHidden = true

    }

    @IBAction func play(_ sender: Any) {
        
        if gameManager.lion.alive == false {
            return print("Dead kitty!")
        }
        
        scene?.catSprite.flipCat(innerFunction:{
            if self.hungryDays > 4 {
                self.scene?.catSprite.animateSickCat()
            } else {
                self.scene?.catSprite.startIdleAnimation()
            }
        })
        print("I should be flipping!")
        

        
        if gameManager.lion.happy <= 2 {
            gameManager.lion.happy += 1
            print (gameManager.lion.happy)
            happiness.text = String("\(countHappiness())")
        }
        
        playDays = 0
    }

    
    @IBAction func updatemeal(_ sender: Any) {
        if countStomachContents() >= 3 {
            self.poopVisual.isHidden = false
            return print("I'm full!")
        }
        gameManager.lion.eat(meal: "kiwi")

        if countStomachContents() == 1 {
            fillIceCreamArray(firstIceCream: "icecreamone.png")
        } else if countStomachContents() == 2 {
            fillIceCreamArray(firstIceCream: "icecreamone.png", secondIceCream: "icecreamtwo.png")
        } else {
            fillIceCreamArray(firstIceCream: "icecreamone.png", secondIceCream: "icecreamtwo.png", thirdIceCream: "icecreamthree.png")
        }

        if hungryDays > 4 && countStomachContents() >= 2{
            hungryDays = 0
            scene?.catSprite.stopSickCatAnimation()
        }

    }

    @objc func updateAge() {
        age += 1
        ageLabel.text = String(age)
        updateTempLabel()
        
        if gameManager.egg.wearingHat == true && gameManager.lion.born == false {
            gameManager.egg.temp += 1
            if gameManager.egg.temp >= 18 {
                scene?.crackEgg()
                scene?.hatchLion()
                happiness.text = String("\(countHappiness())")
            }
        }
        
        if gameManager.lion.born == true {
            playDays += 1
            if playDays >= 2 {
                gameManager.lion.happy -= 1
                happiness.text = String("\(countHappiness())")
            }
            
            if countStomachContents() < 2 {
                if countStomachContents() == 0 {
                    hungryDays += 1
                }
                
                if hungryDays > 4 {
                    scene?.catSprite.animateSickCat()
                }
                
                if hungryDays > 10 {
                    scene?.catSprite.animateDeadCat()
                    ageTracker.invalidate()
                    ageActivated = false
                    gameManager.lion.alive = false
                }
            }
            
        }
    
        if let pooCounter = scene?.pooCounter {
            if pooCounter > 0 {
                gameManager.lion.happy -= 1
                happiness.text = String("\(countHappiness())")
            }
        }
        
        if countStomachContents() == 3 {
            gameManager.lion.pooNow() //empty stomach contents of lion class logic
            fillIceCreamArray()
            scene?.pooQuery() //creates the visual Poo on the screen and increments array and counter of poo
            self.poopVisual.isHidden = true //hides the poo button
            
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.stomachContentsStatus(statement: "It's starting to smell! :^(", bool: false)
            }
           
        }
        
        if countStomachContents() <= 1 && gameManager.lion.born == true && scene?.pooCounter == 0 {
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.stomachContentsStatus(statement: "pweez feed me :'(", bool: false)
            }
        }
        
        if countStomachContents() >= 2 && gameManager.lion.born == true && scene?.pooCounter == 0 {
            stomachContentsStatus(statement: "Thank you for feeding me! >^_^<", bool: true)
            
        }
    }
    
    func stomachContentsStatus(statement: String, bool: Bool){
        self.thoughtBubbleText.text = statement
        self.thoughtBubble.isHidden = bool
        self.thoughtBubbleText.isHidden = bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.poopVisual.isHidden = true
        self.feedVisual.isHidden = true
        self.thoughtBubble.isHidden = true
        self.thoughtBubbleText.isHidden = true
        self.thoughtBubbleText.textAlignment = .center;
        foodUIHide(bool: true)
        updateTempLabel()
        ageTracker = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(updateAge)), userInfo: nil, repeats: true)
        
        if let view = self.view as! SKView? {
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }


    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func hideEggUI(){
        self.tempLabel.isHidden = true
        self.thermometer.isHidden = true
    }

    
    func foodUIHide(bool: Bool){
        self.IceCreamOne.isHidden = bool
        self.IceCreamTwo.isHidden = bool
        self.IceCreamThree.isHidden = bool
        self.foodLabel.isHidden = bool
    }

    func resizeRetextureEggToHatEgg(){
        scene?.eggSprite.texture = SKTexture(imageNamed: "eggWithHat.png")
        scene?.eggSprite.size = CGSize(width:200.0, height: 300.0)
        scene?.eggSprite.physicsBody = SKPhysicsBody(texture: (scene?.eggSprite.texture)!, size: (scene?.eggSprite.size)!);
    }
    
    func fillIceCreamArray(firstIceCream: String? = "icecreamfour.png", secondIceCream: String? = "icecreamfour.png", thirdIceCream: String? = "icecreamfour.png"){
        IceCreamOne.image = UIImage(named: firstIceCream!)
        IceCreamTwo.image = UIImage(named: secondIceCream!)
        IceCreamThree.image = UIImage(named: thirdIceCream!)
    }
    
    func updateTempLabel(){
        tempLabel.text = "\(gameManager.egg.temp)°C"
    }
    
    func countStomachContents() -> Int {
       return gameManager.lion.stomachContents.count
    }
    
    func countHappiness() -> Int {
        return gameManager.lion.happy
    }

}

/* When the cat is out of the egg, it will check if it's stomach is empty and it's age is above a certain amount before it animates */
