//
//  HelpScene.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Trevor Pirone on 4/17/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit

class HelpScene: SKScene {

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint.zero
        self.backgroundColor = SKColor.black

        // Add a label for how to play title.
        let lblHowToPlay = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblHowToPlay.fontSize = 36
        lblHowToPlay.fontColor = SKColor.white
        lblHowToPlay.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.25)
        lblHowToPlay.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblHowToPlay.text = "How to Play"
        addChild(lblHowToPlay)

        // Add a label for jump title.
        let lblJump = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblJump.fontSize = 30
        lblJump.fontColor = SKColor.white
        lblJump.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.75)
        lblJump.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblJump.text = "Jump"
        addChild(lblJump)

        // Description of the rules.
        let lblRules = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblRules.fontSize = 16
        lblRules.fontColor = SKColor.white
        lblRules.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2.5)
        lblRules.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblRules.text = "Press the left button to make Tyler jump left.\n" +
            "Press the right button to make Tyler jump right.\n" +
            "Jump as high as you can to score more points.\n"
        lblRules.lineBreakMode = .byWordWrapping
        lblRules.numberOfLines = 0
        addChild(lblRules)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Transition back to the game.
        let reveal = SKTransition.fade(withDuration: 0.5)
        let splashScene = SplashScene(size: self.size)
        self.view!.presentScene(splashScene, transition: reveal)
    }

}
