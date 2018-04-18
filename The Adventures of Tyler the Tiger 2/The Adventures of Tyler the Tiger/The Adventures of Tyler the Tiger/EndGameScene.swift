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
        lblTryAgain.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
        lblTryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblTryAgain.text = "Game Over For Now..."
        addChild(lblTryAgain)

        // Add a label to indicate the final score.
        let lblScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblScore.fontSize = 36
        lblScore.fontColor = SKColor.white
        lblScore.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        lblScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblScore.text = "Score: \(GameScene.playerScore.score)"
        addChild(lblScore)

        // Add a label to indicate the high score.
        let lblHighScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblHighScore.fontSize = 36
        lblHighScore.fontColor = SKColor.white
        lblHighScore.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.75)
        lblHighScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        lblHighScore.text = "High Score: \(GameScene.playerScore.highScore)"
        addChild(lblHighScore)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Transition back to the Game
        let reveal = SKTransition.fade(withDuration: 0.5)
        let splashScene = SplashScene(size: self.size)
        self.view!.presentScene(splashScene, transition: reveal)
    }

}
