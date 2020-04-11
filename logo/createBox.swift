//
//  createBox.swift
//  logo
//
//  Created by Dane Muldoon on 5/4/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

func createBox() -> SCNNode {
    let boxNode = SCNNode()
    
    // originally debugCube & debugNode were used for debugging the pivot point of the box
    // but I found have this large node helped to balance out the centre of mass
    // set to fully transparent and added to boxNode as final step after all other transformations
    let redMaterial = SCNMaterial()
    redMaterial.diffuse.contents = UIColor.red
    redMaterial.transparency = 0.0
    redMaterial.locksAmbientWithDiffuse = true
    let debugCube: SCNGeometry = SCNBox(width: 11.8, height: 11.8, length: 11.8, chamferRadius: 0)
    debugCube.materials = [redMaterial]
    let debugNode = SCNNode(geometry: debugCube)
    boxNode.addChildNode(debugNode)
    
    let breadth: CGFloat = 1
    let length: CGFloat = 3
    let depth: CGFloat = 0.1
    let cubeSide: Float = 10
    
    // basically these values were all worked out by trial and error ;)
    let adjust: Float = 1.5
    let small: Float = 0.5
    let pivotXoffset: Float = 5.65
    let pivotYoffset: Float = -6
    let pivotZoffset: Float = 4.25
    
    let corner1 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner1.position = SCNVector3Make(-0.2+pivotXoffset,
                                      0.1+pivotYoffset,
                                      0.2+pivotZoffset)
    boxNode.addChildNode(corner1)
    
    let corner2 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner2.rotation = SCNVector4Make(1, 0, 0, .pi/2)
    corner2.position = SCNVector3Make(-0.2+pivotXoffset,
                                      adjust+pivotYoffset,
                                      -cubeSide-0.2+pivotZoffset)
    boxNode.addChildNode(corner2)
    
    let corner3 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner3.rotation = SCNVector4Make(0, 0, 1, .pi/2)
    corner3.position = SCNVector3Make(small-0.2+pivotXoffset,
                                      cubeSide+adjust+pivotYoffset,
                                      0.2+pivotZoffset)
    boxNode.addChildNode(corner3)
    
    let corner4 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner4.rotation = SCNVector4Make(1, 0, 0, .pi)
    corner4.position = SCNVector3Make(-0.15+pivotXoffset,
                                      cubeSide+adjust+small-0.05+pivotYoffset,
                                      -cubeSide+adjust-0.2+pivotZoffset)
    boxNode.addChildNode(corner4)
    
    let corner5 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner5.rotation = SCNVector4Make(0, 1, 0, -.pi/2)
    corner5.position = SCNVector3Make(-cubeSide-0.1+pivotXoffset,
                                      0.05+pivotYoffset,
                                      adjust-small+0.2+pivotZoffset)
    boxNode.addChildNode(corner5)
    
    let corner6 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner6.rotation = SCNVector4Make(0, 0, 1, .pi)
    corner6.position = SCNVector3Make(-cubeSide-adjust+small-0.1+pivotXoffset,
                                      cubeSide+adjust+small-0.05+pivotYoffset,
                                      0.2+pivotZoffset)
    boxNode.addChildNode(corner6)
    
    let corner7 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner7.rotation = SCNVector4Make(1, 1, 0, .pi)
    corner7.position = SCNVector3Make(-cubeSide-adjust-0.1+pivotXoffset,
                                      cubeSide+adjust+pivotYoffset,
                                      -cubeSide+adjust-0.2+pivotZoffset)
    boxNode.addChildNode(corner7)
    
    let corner8 = makeCorner(breadth: breadth, length: length, depth: depth)
    corner8.rotation = SCNVector4Make(0, 1, 0, -.pi)
    corner8.position = SCNVector3Make(-cubeSide-adjust+0.35+pivotXoffset,
                                      0.05+pivotYoffset,
                                      -cubeSide+adjust-0.2+pivotZoffset)
    boxNode.addChildNode(corner8)
    
    
    boxNode.position = SCNVector3Make(cubeSide/2+adjust/2, -cubeSide/2-adjust/2, cubeSide/2-adjust/2)
    
    var matrix1: SCNMatrix4
    var spinY: SCNMatrix4
    let rotationInY: Float = .pi/4
    
    matrix1 = SCNMatrix4(m11: 1,    m12: 0,     m13: 0,    m14: 0,
                         m21: 0,    m22: 1,     m23: 0,    m24: 0,
                         m31: 0,    m32: 0,     m33: 1,    m34: 0,
                         m41: 7,    m42: -6,    m43: -1,   m44: 1)
    
    spinY = SCNMatrix4(m11: cos(rotationInY), m12: 0, m13: -sin(rotationInY),    m14: 0,
                         m21: 0,          m22: 1, m23: 0,              m24: 0,
                         m31: sin(rotationInY), m32: 0, m33: cos(rotationInY),     m34: 0,
                         m41: 0,          m42: 0, m43: 0,              m44: 1)

    boxNode.transform = SCNMatrix4Mult(spinY, matrix1)
    
    boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    boxNode.name = "box"
    
     boxNode.addChildNode(debugNode)
    
    return boxNode
}
