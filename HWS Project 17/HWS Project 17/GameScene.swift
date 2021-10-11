//
//  GameScene.swift
//  HWS Project 17
//
//  Created by Christopher Koski on 10/10/21.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var starfield: SKEmitterNode!
  var player: SKSpriteNode!
  var scoreLabel: SKLabelNode!
  var enemyCountLabel: SKLabelNode!
  
  var possibleEnemies = ["ball", "hammer", "tv"]
  var gameTimer: Timer?
  //    get { return self.gameTimer }
  //    set { gameTimer? = newValue! }
  var isGameOver = false
  var starterInterval: Double = 1.0
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  
  
  var enemyCount = 0 {
    didSet {
      enemyCountLabel.text = "Enemies Passed: \(enemyCount)"
    }
  }
  //    didSet {
  //      if enemyCount % 20 == 0 {
  //        gameTimer?.invalidate()
  //        gameTimer? = Timer.scheduledTimer(timeInterval: starterInterval - 0.1, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
  //      }
  //    }
  //  }
  
  
  
  override func didMove(to view: SKView) {
    backgroundColor = .black
    
    starfield = SKEmitterNode(fileNamed: "starfield")
    starfield.position = CGPoint(x: 1024, y: 384)
    starfield.advanceSimulationTime(10)
    
    addChild(starfield)
    
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 100, y: 384)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    player.physicsBody?.contactTestBitMask = 1
    addChild(player)
    
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.position = CGPoint(x: 30, y: 30)
    scoreLabel.horizontalAlignmentMode = .left
    addChild(scoreLabel)
    
    enemyCountLabel = SKLabelNode(fontNamed: "Chalkduster")
    enemyCountLabel.position = CGPoint(x: 600, y: 30)
    enemyCountLabel.horizontalAlignmentMode = .left
    enemyCountLabel.text = "Enemies Passed: \(enemyCount)"
    addChild(enemyCountLabel)
    
    score = 0
    
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    
    gameTimer = Timer.scheduledTimer(timeInterval: starterInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    
  }
  
  override func update(_ currentTime: TimeInterval) {
    for node in children {
      if node.position.x < -300 {
        node.removeFromParent()
      }
    }
    
    if !isGameOver {
      score += 1
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    var location = touch.location(in: self)
    
    if location.y < 100 {
      location.y = 100
    } else if location.y > 668 {
      location.y = 668
    }
    
    player.position = location
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let explosion = SKEmitterNode(fileNamed: "explosion")!
    explosion.position = player.position
    addChild(explosion)
    
    player.removeFromParent()
    possibleEnemies.removeAll()
    
    isGameOver = true
  }
  
  @objc func createEnemy() {
    guard let enemy = possibleEnemies.randomElement() else { return }
    
    let sprite = SKSpriteNode(imageNamed: enemy)
    sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
    addChild(sprite)
    
    sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
    sprite.physicsBody?.categoryBitMask = 1
    sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
    sprite.physicsBody?.angularVelocity = 5
    sprite.physicsBody?.linearDamping = 0
    sprite.physicsBody?.angularDamping = 0
    enemyCount += 1
    
    if starterInterval > 0.2 {
      if enemyCount > 0 && enemyCount % 5 == 0 {
        gameTimer?.invalidate()
        starterInterval -= 0.1
        gameTimer = Timer.scheduledTimer(timeInterval: starterInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
      }
    }
    
    
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    let explosion = SKEmitterNode(fileNamed: "explosion")!
    explosion.position = player.position
    addChild(explosion)
    
    player.removeFromParent()
    possibleEnemies.removeAll()
    isGameOver = true
  }
}
