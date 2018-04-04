//
//  EndGameScene.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Trevor Pirone on 3/26/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit

class EndGameScene: SKScene {

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint.zero
        let background = SKSpriteNode(imageNamed: "GameScreen")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        background.zPosition = -10
        addChild(background)

        // Add a label to indicate the game is over.
        let lblTryAgain = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblTryAgain.fontSize = 36
        lblTryAgain.fontColor = SKColor.white
        lblTryAgain.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        lblTryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblTryAgain.text = "Game Over For Now..."
        addChild(lblTryAgain)
    }

}
