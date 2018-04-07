//
//  GameScene.swift
//  Pong
//
//  Created by Markus Eriksson on 2018-04-07.
//  Copyright © 2018 Markus Eriksson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // konstruktor
    var ball = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var playerPaddle = SKSpriteNode()
    
    var playerScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    var score = [Int]()
    
    
    override func didMove(to view: SKView) {
        
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        enemyPaddle.position.y = (self.frame.height / 2) - 30
        
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        playerPaddle.position.y = (-self.frame.height / 2) + 30
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        
        enemyScore.text = "\(score[1])"
        playerScore.text = "\(score[0])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -7, dy: 7)) // gives ball force, speed.
    }
    
    func addScore(playerWhoScored : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        
        if playerWhoScored == playerPaddle {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -7, dy: 7)) // speed at which ball flies
        }
        else if playerWhoScored == enemyPaddle {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 7, dy: -7)) // speed at which ball flies
           
        }
        
        enemyScore.text = "\(score[1])"
        playerScore.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //  moves player paddle when touching screen
        for touch in touches {
            let location = touch.location(in: self) // grabs location of finger in view
            
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //  moves player paddle when dragging finger over screen
        for touch in touches {
            let location = touch.location(in: self) // grabs location of finger in view
            
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.0)) // enemy paddle moves
            break
        case .hard:
            enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.5)) // enemy paddle moves
            break
        }
        
        if ball.position.y <= playerPaddle.position.y - 10 { // "-30" is where ball scores
            addScore(playerWhoScored: enemyPaddle)
        }
        else if ball.position.y >= enemyPaddle.position.y + 10 {
            addScore(playerWhoScored: playerPaddle)
        }
        
        
    }
}
