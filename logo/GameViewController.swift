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
    }

    func initScene() {
        gameScene = SCNScene()
        gameView.scene = gameScene
        gameView.isPlaying = true
        
        gameScene.rootNode.addChildNode(createCube())
        gameScene.rootNode.addChildNode(createSun())
    }
    
    func initCamera() {
        let camera = SCNCamera()
        cameraNode = SCNNode()
        cameraNode.camera = camera
        
        // cameraNode positioning now working
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, .pi/2)
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
