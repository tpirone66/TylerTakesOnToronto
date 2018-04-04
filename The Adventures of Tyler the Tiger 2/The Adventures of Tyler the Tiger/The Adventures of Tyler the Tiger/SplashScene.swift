//
//  SplashScene.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Marist User on 3/5/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit

class SplashScene: SKScene {

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint.zero
        let background = SKSpriteNode(imageNamed: "background")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        addChild(background)
        let tapMethod = #selector(SplashScene.handleTap(tapGesture:))
        let tapGesture = UITapGestureRecognizer(target: self, action: tapMethod)
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        goNext(scene: GameScene())
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
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
