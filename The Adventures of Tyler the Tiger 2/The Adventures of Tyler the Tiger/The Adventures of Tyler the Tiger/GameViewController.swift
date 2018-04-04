//
//  GameViewController.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Marist User on 3/5/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'SplashScene.sks'.
            if let scene = SKScene(fileNamed: "SplashScene") {
                // Set the scale mode to scale to fit the window.
                scene.scaleMode = .resizeFill
                // Present the scene.
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
