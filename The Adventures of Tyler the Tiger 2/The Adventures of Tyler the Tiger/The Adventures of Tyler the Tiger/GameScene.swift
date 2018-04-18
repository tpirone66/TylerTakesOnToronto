//
//  GameScene.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Marist User on 3/5/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    var foregroundNode: SKNode!
    var backgroundNode: SKNode!
    var gameOver = false
    var leftMove: SKSpriteNode!
    var rightMove: SKSpriteNode!
    var endLevelY = 0
    let player = Player(imageNamed: "Tyler")
    var audioPlayer: AVAudioPlayer!
    let score = playerScore.score
    let highScore = playerScore.highScore
    var gameState = GameState.notRunning
    var maxPlayerY: Int!

    enum GameState {
        case notRunning
        case running
    }

    override func didMove(to view: SKView) {
        gameState = .running
        anchorPoint = CGPoint.zero
        backgroundNode = SKNode()
        let background = SKSpriteNode(imageNamed: "GameScreen")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        background.zPosition = -10.0
        backgroundNode.addChild(background)
        addChild(backgroundNode)
        let url = Bundle.main.url(forResource: "Tyler", withExtension: "m4a")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        maxPlayerY = 95
        playerScore.score = 0
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        leftMove = SKSpriteNode(imageNamed: "Left")
        leftMove.position = CGPoint(x: 32, y: 64)
        addChild(leftMove)
        rightMove = SKSpriteNode(imageNamed: "Right")
        rightMove.position = CGPoint(x: 384, y: 64)
        addChild(rightMove)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        foregroundNode = SKNode()
        addChild(foregroundNode)
        player.setupPhysicsBody()
        foregroundNode.addChild(player)
        player.position = CGPoint(x: self.size.width / 2, y: 80.0)
        let platform = createPlatformAtPosition(position: CGPoint(x: xMid, y: 70), ofType: PlatformType.normalPlatform)
        foregroundNode.addChild(platform)
        // Load the level.
        let levelPlist = Bundle.main.path(forResource: "Level01", ofType: "plist")
        let levelData = NSDictionary(contentsOfFile: levelPlist!)!
        // Height at which the player ends the level.
        endLevelY = (levelData["EndY"]! as AnyObject).integerValue!
        // Add the platforms.
        let platforms = levelData["Platforms"] as! NSDictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]
        for platformPosition in platformPositions {
            let patternX = (platformPosition["x"] as AnyObject).floatValue
            let patternY = (platformPosition["y"] as AnyObject).floatValue
            let pattern = platformPosition["pattern"] as! NSString
            // Look up the pattern.
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            for platformPoint in platformPattern {
                let x = (platformPoint["x"] as AnyObject).floatValue
                let y = (platformPoint["y"] as AnyObject).floatValue
                let type = PlatformType(rawValue: (platformPoint["type"]! as AnyObject).integerValue)
                let positionX = CGFloat(x! + patternX!)
                let positionY = CGFloat(y! + patternY!)
                let platformNode = createPlatformAtPosition(
                    position: CGPoint(x: positionX, y: positionY), ofType: type!)
                foregroundNode.addChild(platformNode)
            }
        }
    }

    func updatePlayer() {
        // Determine if the player is currently on the ground.
        if let velocityY = player.physicsBody?.velocity.dy {
            if velocityY < -100.0 || velocityY > 100.0 {
                player.isOnGround = false
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leftMove.name = "Left"
        rightMove.name = "Right"
        if gameState == .running {
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                let node = self.atPoint(location)
                player.physicsBody?.isDynamic = true
                if player.isOnGround {
                    if node.name == "Left" {
                        // Move the player to the left.
                        player.physicsBody?.applyImpulse(CGVector(dx: -2.5, dy: 6.0))
                    } else if node.name == "Right" {
                        // Move the player to the right.
                        player.physicsBody?.applyImpulse(CGVector(dx: 2.5, dy: 6.0))
                    } } else {
                            if node.name == "Left" {
                                // Move the player to the left.
                                player.physicsBody?.applyImpulse(CGVector(dx: -0.5, dy: 0.5))
                            } else if node.name == "Right" {
                                // Move the player to the right.
                                player.physicsBody?.applyImpulse(CGVector(dx: 0.5, dy: 0.5))
                            }
                        }
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        // Check if the contact is between the player and a platform.
        if contact.bodyA.categoryBitMask == CollisionBitMask.Player
            && contact.bodyB.categoryBitMask == CollisionBitMask.Platform {
            player.isOnGround = true
            player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 0.0))
        }
    }

    func currScore() {
        // Player jumps higher than inital start value, increase score.
        if Int(player.position.y) > maxPlayerY {
            playerScore.score += Int(player.position.y) - maxPlayerY
            // Set a new max player value to the player's current position.
            maxPlayerY = Int(player.position.y)
        }
        // Store the high score if the current score exceeds it.
        if playerScore.score > playerScore.highScore {
            playerScore.highScore = playerScore.score
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered.
        updatePlayer()
        currScore()
        if gameOver {
            return
        }
        if gameState != .running {
            return
        }
        // Player reaches the top value.
        if Int(player.position.y) > endLevelY {
            endGame()
        }
        // Player falls off the screen.
        if Int(player.position.y) < -100 {
            endGame()
        }
        // Scroll the platforms upward in the level.
        if Int(player.position.y) > 200 {
            foregroundNode.position = CGPoint(x: 0.0, y: -(player.position.y - 200.0))
        }
        // Player jumps far off-screen left and reappears on the right side.
        if Int(player.position.x) < -20 {
            player.position = CGPoint(x: self.size.width + 20.0, y: player.position.y)
        } else if Int(player.position.x) > Int(self.size.width + 20) {
            // Player jumps off-screen right and reappears on the left side.
            player.position = CGPoint(x: -20.0, y: player.position.y)
        }
    }

    // Called if the player dies or reaches the end of the level.
    func endGame() {
        gameState = .notRunning
        gameOver = true
        let reveal = SKTransition.crossFade(withDuration: 0.5)
        let endGameScene = EndGameScene(size: self.size)
        self.view!.presentScene(endGameScene, transition: reveal)
        audioPlayer.stop()
    }

}
