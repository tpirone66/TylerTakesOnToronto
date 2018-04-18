//
//  GameElements.swift
//  The Adventures of Tyler the Tiger
//
//  Created by Trevor Pirone on 3/25/18.
//  Copyright © 2018 Marist User. All rights reserved.
//

import SpriteKit

extension GameScene {

    // Set up a CollisionBitMask struct.
    struct CollisionBitMask {
        static let Player: UInt32 = 0x00
        static let Platform: UInt32 = 0x01
    }

    // Set up an enumerator for platforms.
    enum PlatformType: Int {
        case normalPlatform = 0
    }

    // GenericNode class contains a function that returns player collision detections of objects.
    class GenericNode: SKNode {
        func collisionWithPlayer(player: SKNode) -> Bool {
            return false
        }
    }

    // PlatformNode class.
    class PlatformNode: GenericNode {
        var platformType: PlatformType!
    }

    // Player class.
    class Player: SKSpriteNode {

        // Properties of the Player class.
        var velocity = CGPoint.zero
        var minimumY: CGFloat = 0.0
        var jumpSpeed: CGFloat = 20.0
        var isOnGround = true

        // This function sets up the player's physics and how the player interacts
        // in the game.
        func setupPhysicsBody() {

            if let playerTexture = texture {
                physicsBody = SKPhysicsBody(texture: playerTexture, size: size)
                physicsBody?.isDynamic = true
                physicsBody?.allowsRotation = false
                physicsBody?.restitution = 0.0
                physicsBody?.friction = 5.0
                physicsBody?.angularDamping = 0.0
                physicsBody?.linearDamping = 0.0
                physicsBody?.categoryBitMask = CollisionBitMask.Player
                physicsBody?.collisionBitMask = CollisionBitMask.Platform
                physicsBody?.contactTestBitMask = CollisionBitMask.Platform
            }
        }

    }

    // This function is responsible for creating platforms and how platforms interact
    // in the game.
    func createPlatformAtPosition(position: CGPoint, ofType type: PlatformType) -> PlatformNode {

        let platNode = PlatformNode()
        anchorPoint = CGPoint.zero
        let position = CGPoint(x: position.x, y: position.y)
        platNode.position = position
        platNode.name = "PLATFORM"
        platNode.platformType = type
        var platSprite: SKSpriteNode
        platSprite = SKSpriteNode(imageNamed: "Platform")
        platNode.addChild(platSprite)
        platNode.physicsBody = SKPhysicsBody(rectangleOf: platSprite.size)
        platNode.physicsBody?.isDynamic = false
        platNode.physicsBody?.affectedByGravity = false
        platNode.physicsBody?.categoryBitMask = CollisionBitMask.Platform
        platNode.physicsBody?.collisionBitMask = 0
        return platNode
    }

    struct playerScore {
        static var score: Int = 0
        static var highScore: Int = 0
    }

}
