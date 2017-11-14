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
    @IBOutlet weak var meals: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var IceCreamOne: UIImageView!
    @IBOutlet weak var IceCreamTwo: UIImageView!
    @IBOutlet weak var IceCreamThree: UIImageView!
    @IBOutlet weak var touchHatVisual: UIButton!
    @IBOutlet weak var poopVisual: UIButton!
    @IBOutlet weak var feedVisual: UIButton!
    
    @IBOutlet weak var happiness: UILabel!
    

    var age = 0
    var ageActivated = true
    var ageTracker = Timer()
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
        meals.text = "\(countStomachContents())"
        IceCreamOne.image = UIImage(named: "icecreamfour.png")
        IceCreamTwo.image = UIImage(named: "icecreamfour.png")
        IceCreamThree.image = UIImage(named: "icecreamfour.png")
        scene?.pooQuery()
        self.poopVisual.isHidden = true

    }

    @IBAction func play(_ sender: Any) {
        happiness.text = String("\(countHappiness())")
        scene?.catSprite.flipCat()
        print("I should be flipping!")
        if gameManager.lion.happy <= 2 {
            gameManager.lion.happy += 1
            print (gameManager.lion.happy)
        }
    }

    
    @IBAction func updatemeal(_ sender: Any) {
        if countStomachContents() >= 3 {
            self.poopVisual.isHidden = false
            return print("I'm full!")
        }
        gameManager.lion.eat(meal: "kiwi")

        if countStomachContents() == 1 {
            IceCreamOne.image = UIImage(named: "icecreamone.png")
        } else if countStomachContents() == 2 {
            IceCreamOne.image = UIImage(named: "icecreamone.png")
            IceCreamTwo.image = UIImage(named: "icecreamtwo.png")
        } else {
            IceCreamOne.image = UIImage(named: "icecreamone.png")
            IceCreamTwo.image = UIImage(named: "icecreamtwo.png")
            IceCreamThree.image = UIImage(named: "icecreamthree.png")
        }

        meals.text = String("\(countStomachContents())")

    }

    @objc func updateAge() {
        age += 1
        ageLabel.text = String(age)
        if gameManager.egg.wearingHat == true {
            gameManager.egg.temp += 1
        }
        updateTempLabel()
        if let pooCounter = scene?.pooCounter {
            if pooCounter > 0 {
                gameManager.lion.happy -= 1
                happiness.text = String("\(countHappiness())")
                
            }
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        self.poopVisual.isHidden = true
        self.feedVisual.isHidden = true
        hideFoodUI()
        updateTempLabel()

        ageTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateAge)), userInfo: nil, repeats: true)



        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameplayScene.sks'
//            if let scene = GameplayScene(fileNamed: "GameplayScene") {
                // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            scene?.viewController = self
                // Present the scene
                view.presentScene(scene)

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }


    }

    override var shouldAutorotate: Bool {
        return true
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

    func showFoodUI() {
        self.IceCreamOne.isHidden = false
        self.IceCreamTwo.isHidden = false
        self.IceCreamThree.isHidden = false
        self.foodLabel.isHidden = false
    }
    
    func hideFoodUI() {
        self.IceCreamOne.isHidden = true
        self.IceCreamTwo.isHidden = true
        self.IceCreamThree.isHidden = true
        self.foodLabel.isHidden = true

    }

    func resizeRetextureEggToHatEgg(){
        scene?.eggSprite.texture = SKTexture(imageNamed: "eggWithHat.png")
        scene?.eggSprite.size = CGSize(width:200.0, height: 300.0)
        scene?.eggSprite.physicsBody = SKPhysicsBody(texture: (scene?.eggSprite.texture)!, size: (scene?.eggSprite.size)!);
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
