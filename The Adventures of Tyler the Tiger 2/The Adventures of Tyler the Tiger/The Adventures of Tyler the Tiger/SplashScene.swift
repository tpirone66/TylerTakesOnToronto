//
//  SplashScene.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Marist User on 3/5/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit

class SplashScene: SKScene {

    var help: SKSpriteNode!

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint.zero
        let background = SKSpriteNode(imageNamed: "background")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        addChild(background)
        help = SKSpriteNode(imageNamed: "questionmark")
        help.position = CGPoint(x: xMid / 0.55, y: yMid / 4)
        help.zPosition = 10.0
        addChild(help)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        help.name = "questionmark"
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            // If the user touches the question mark button, go to help screen.
            if node.name == "questionmark" {
                goNext(scene: HelpScene())
            } else {
                // Transition into the main game.
                goNext(scene: GameScene())
            }
        }
    }

    func goNext(scene: SKScene) {
        // View is an SKView? so we have to check.
        if let view = self.view {
            // Set the scale mode to scale to fit the window.
            scene.scaleMode = .resizeFill
            // Adjust the size of the scene to match the view.
            let width = view.bounds.width
            let height = view.bounds.height
            scene.size = CGSize(width: width, height: height)
            let reveal = SKTransition.crossFade(withDuration: 5)
            view.presentScene(scene, transition: reveal)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

}
