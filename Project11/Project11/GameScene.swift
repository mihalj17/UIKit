//
//  GameScene.swift
//  Project11
//
//  Created by Matko Mihaljl on 18.08.2022..
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var scoreLabel: SKLabelNode!
    var textures = [SKSpriteNode]()
    var ballCounter : SKLabelNode!
    
    
    var score = 0{
        didSet {
            scoreLabel.text = "Score : \(score)"
        }
    }
    
    var counterForBall = 5 {
        didSet{
            ballCounter.text = "Ball remaining : \(counterForBall)"
        }
    }
    
    var editLabel:SKLabelNode!
    
    var editingMode: Bool = false{
        didSet{
            if editingMode {
                editLabel.text = "Done"
            }else {
                editLabel.text = "Edit"
            }
        }
    }
    
    
    
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 900, y: 500)
        addChild(scoreLabel)
        
        ballCounter = SKLabelNode(fontNamed: "Chalkduster")
        ballCounter.text = "Ball remaining: 5"
        ballCounter.horizontalAlignmentMode = .center
        ballCounter.position = CGPoint(x: 500, y: 500)
        addChild(ballCounter)
        
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 150, y: 500)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        textures.append(SKSpriteNode(imageNamed: "ballRed"))
        textures.append(SKSpriteNode(imageNamed: "ballBlue"))
        textures.append(SKSpriteNode(imageNamed: "ballGreen"))
        textures.append(SKSpriteNode(imageNamed: "ballGrey"))
        textures.append(SKSpriteNode(imageNamed: "ballCyan"))
        textures.append(SKSpriteNode(imageNamed: "ballPurple"))
        
        textures.append(SKSpriteNode(imageNamed: "ballYellow"))

       
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in : self)
        print(location.y)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel){
            
            editingMode.toggle()
            
        } else {
            
            if editingMode{
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green:CGFloat.random(in: 0...1) , blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody=SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "box"
                addChild(box)
            }
            else {
                if(location.y>400 && counterForBall > 0 ){
//            let ball = SKSpriteNode(imageNamed: "ballRed")
            let rand = Int(arc4random_uniform(UInt32(textures.count)))
            let ball = textures[rand] as SKSpriteNode
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody?.restitution = 0.4
            ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
            ball.position = location
            ball.name = "ball"
            counterForBall -= 1
            ball.removeFromParent()
            addChild(ball)
                }}
        }
        
        
        
    }
    
    
    func makeBouncer(at position : CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    func makeSlot(at position : CGPoint, isGood : Bool){
        var slotGlow: SKSpriteNode
        var slotBase: SKSpriteNode
        
        if isGood{
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }
        else{
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        slotBase.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode){
        if object.name == "good"{
            destroy(ball: ball)
            score += 1
            counterForBall += 1
        }
        else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            
        }
        
        if object.name == "box"{
            destroyBox(box: object)
        }
        
        
    }
    func destroy(ball: SKNode){
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"){
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func destroyBox(box: SKNode){
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles"){
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        
        box.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA.name == "ball"{
            collision(between: nodeA , object: nodeB)
        } else if nodeB.name == "ball"{
            collision(between: nodeB, object: nodeA)
        }
    }
}
