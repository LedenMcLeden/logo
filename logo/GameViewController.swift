//
//  GameViewController.swift
//  logo
//
//  Created by Dane Muldoon on 21/3/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var gameView: SCNView!
    var gameScene: SCNScene!
    var cameraNode: SCNNode!
    var targetCreationTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initScene()
        initCamera()
    }
    
    func initView() {
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = true
        gameView.autoenablesDefaultLighting = true
        gameView.showsStatistics = false
    }

    func initScene() {
        gameScene = SCNScene()
        gameScene.physicsWorld.gravity = SCNVector3(0.0, 0.0, 0.0)
        gameView.scene = gameScene
        gameView.isPlaying = true
        
        gameScene.rootNode.addChildNode(createBox())
        gameScene.rootNode.addChildNode(createSun())
    }
    
    func initCamera() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.fieldOfView = 80

        var matrix1: SCNMatrix4
        matrix1 = SCNMatrix4(m11: 1,     m12: 0,     m13: 0,     m14: 0,
                             m21: 0,     m22: 1,     m23: 0,     m24: 0,
                             m31: 0,     m32: 0,     m33: 1,     m34: 0,
                             m41: 7,     m42: -6,    m43: 25,    m44: 1)

        cameraNode.transform = SCNMatrix4Mult(matrix1, SCNMatrix4Identity)
        
        gameScene.rootNode.addChildNode(cameraNode)
    }
    
    func handleTouch(node: SCNNode) {
        let boxNode = gameScene.rootNode.childNode(withName: "box",
        recursively: true)
        let randomX = Float.random(in: -10 ... 10)
        let randomY = Float.random(in: -10 ... 10)
        let randomZ = Float.random(in: -10 ... 10)
        
        // used to quickly check rotation in one dimenion
        // let randomX: Float = 1.0
        // let randomY: Float = 0.0
        // let randomZ: Float = 0.0
        
        // applyTorque changes the angular momentum of the node
        // use this to spin the box
        let torque: SCNVector4
        torque = SCNVector4(x: randomX, y: randomY, z: randomZ, w: .pi)
        boxNode?.physicsBody?.applyTorque(torque, asImpulse: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // identify location and then object being touched - pass to handleTouch
        let touch = touches.first!
        let location = touch.location(in: gameView)
        let hitResults = gameView.hitTest(location, options: nil)
        if let result = hitResults.first {
            handleTouch(node: result.node)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
