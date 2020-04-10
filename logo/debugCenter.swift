//
//  debugCenter.swift
//  logo
//
//  Created by Dane Muldoon on 10/4/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

func debugCenter() -> SCNNode {
    let centerNode = SCNNode()

    let redMaterial = SCNMaterial()
    redMaterial.diffuse.contents = UIColor.red
    redMaterial.locksAmbientWithDiffuse = true
    
    let debugCube: SCNGeometry = SCNBox(width: 11, height: 11, length: 11, chamferRadius: 0)
    debugCube.materials = [redMaterial]
    
    let debugNode = SCNNode(geometry: debugCube)
    debugNode.rotation = SCNVector4Make(0, 1, 0, .pi/4)
    
    centerNode.addChildNode(debugNode)
    return centerNode
}
