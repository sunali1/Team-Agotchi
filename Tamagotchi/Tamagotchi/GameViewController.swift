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
    
    
    var age = 6
    var mealsCount = 0
    var ageActivated = true
    var ageTracker = Timer()
    
    @IBAction func touchHatButton(_ sender: Any) {
        gameManager.egg.helpEgg(item: "Hat")
        tempLabel.text = "\(gameManager.egg.temp)°C"
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
    

    @IBAction func updatemeal(_ sender: Any) {
        if mealsCount == 3 {
            return print("I'm full!")
        }
        gameManager.lion.eat(meal: "kiwi")
        mealsCount += 1
        meals.text = String(mealsCount)
    }

    @objc func updateAge() {
        age += 1
        ageLabel.text = String(age)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempLabel.text = "\(gameManager.egg.temp)°C"
        
        ageTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateAge)), userInfo: nil, repeats: true)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameplayScene.sks'
            if let scene = GameplayScene(fileNamed: "GameplayScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.viewController = self
                // Present the scene
                view.presentScene(scene)
            }
            
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

}



