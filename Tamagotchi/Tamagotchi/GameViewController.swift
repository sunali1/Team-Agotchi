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
    var ageTracker = Timer()
    var age = 6
    
    
    @objc func runAgeTracker() {
        ageTracker = Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(updateAge)), userInfo: nil, repeats: true)    //runs updateAge function once every 60 seconds. So one minute in time equals 1 day in age
    }

    @objc func updateAge() {
        age += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
}



