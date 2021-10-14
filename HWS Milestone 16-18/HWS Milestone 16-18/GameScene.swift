//
//  GameScene.swift
//  HWS Milestone 16-18
//
//  Created by Christopher Koski on 10/13/21.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var gameTimer1:     Timer?
  var gameTimer2:     Timer?
  var gameTimer3:     Timer?
  var scoreLabel:     SKLabelNode!
  var timerLabel:     SKLabelNode!
  var gunChar:        SKSpriteNode!
  var gunSmoke:       SKEmitterNode!
  var breakTarget:    SKEmitterNode!
  var isGameOver:     Bool!
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  var time = 20 
  
  
  
  override func didMove(to view: SKView) {
    
    
    let background       = SKSpriteNode(imageNamed: "21157" )
    background.position  = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    
    scoreLabel          = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text     = "Score: 0"
    scoreLabel.position = CGPoint(x: 8, y: 30)
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.fontSize = 48
    addChild(scoreLabel)
    
    timerLabel = SKLabelNode(fontNamed: "Chalkduster")
    timerLabel.text = "\(time) seconds left"
    timerLabel.position = CGPoint(x: 512, y: 720)
    timerLabel.fontSize = 40
    addChild(timerLabel)
    
    gunChar = SKSpriteNode(imageNamed: "gunAim")
    gunChar.position = CGPoint(x: 512, y: 80)
    gunChar.setScale(0.3)
    addChild(gunChar)
    
    
    gameTimer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    gameTimer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createTarget2), userInfo: nil, repeats: true)
    gameTimer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createTarget3), userInfo: nil, repeats: true)

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      self.time -= 1
      if self.time == 0 {
        self.timerLabel.text = "Game Over"
        self.isGameOver = true
            timer.invalidate()
        self.gameTimer1?.invalidate()
        self.gameTimer2?.invalidate()
        self.gameTimer3?.invalidate()
        
        } else {
          self.timerLabel.text = "\(self.time) Seconds Left"
        }
    }
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let tappedNodes = nodes(at: location)
    
    for node in tappedNodes {
      if node.name == "target" {
        
        breakTarget = SKEmitterNode(fileNamed: "breakTarget")
        breakTarget.position = touch.location(in: self)
        addChild(breakTarget)
        node.removeFromParent()
        
        score += 1
      }
    }
    
    gunSmoke = SKEmitterNode(fileNamed: "gunSmoke")
    gunSmoke.position = CGPoint(x: 470, y: 120)
    addChild(gunSmoke)
    
  }
  
  override func update(_ currentTime: TimeInterval) {
    for node in children {
      if node.position.x < -300 {
        node.removeFromParent()
      }
    }
  }
  
  @objc func createTarget() {
    let randomSpeed = Double.random(in: 0.5...3.0)
    let sprite      = SKSpriteNode(imageNamed: "30103")
    sprite.position = CGPoint(x: 1200, y: 650)
    sprite.setScale(0.15)
    sprite.name = "target"
    addChild(sprite)
    
    let move = SKAction.moveTo(x: -500, duration: randomSpeed)
    sprite.run(move)
    
  }
  
  @objc func createTarget2() {
    let randomSpeed = Double.random(in: 1.0...3.0)
    let sprite      = SKSpriteNode(imageNamed: "30103")
    sprite.position = CGPoint(x: 0, y: 450)
    sprite.setScale(0.15)
    sprite.name = "target"
    addChild(sprite)
    
    let move = SKAction.moveTo(x: 2000, duration: randomSpeed)
    sprite.run(move)
  }
  
  @objc func createTarget3() {
    let randomSpeed = Double.random(in: 1.0...3.0)
    let sprite      = SKSpriteNode(imageNamed: "30103")
    sprite.position = CGPoint(x: 1200, y: 250)
    sprite.setScale(0.15)
    sprite.name = "target"
    addChild(sprite)
    
    let move = SKAction.moveTo(x: -500, duration: randomSpeed)
    sprite.run(move)
  }
  
  func updateTime() {

  }
}
