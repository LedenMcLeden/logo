//
//  corner.swift
//  logo
//
//  Created by Dane Muldoon on 21/3/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit


func makeCorner(breadth: CGFloat, length: CGFloat, depth: CGFloat) -> SCNNode {
    // build one complete 3D corner
    
    /*
                b: breadth
                 ____
                |    |
                |    |
     l: length  |    |
                |    |________
                |             |  b: breadth
                |_____________|
                  l: length

       d: depth = 0.1
     
     */
    
    let b = breadth // 1
    let l = length // 3
    let d = depth // 0.1

    let cornerNode = SCNNode()
    
    let corner1: SCNGeometry = SCNBox(width: b, height: l, length: d, chamferRadius: 0)
    let corner2: SCNGeometry = SCNBox(width: b, height: d, length: l, chamferRadius: 0)
    let corner3: SCNGeometry = SCNBox(width: d, height: l, length: b, chamferRadius: 0)
    let corner4: SCNGeometry = SCNBox(width: d, height: b, length: l, chamferRadius: 0)
    let corner5: SCNGeometry = SCNBox(width: l, height: d, length: b, chamferRadius: 0)
    let corner6: SCNGeometry = SCNBox(width: l, height: b, length: d, chamferRadius: 0)
    
    let whiteMaterial = SCNMaterial()
    whiteMaterial.diffuse.contents = UIColor.white
    whiteMaterial.metalness.contents = 1.0
    whiteMaterial.roughness.contents = 0.0
    // physicallyBased lighting requires a light source positioned at the sun otherwise it reflects in a funny way
    // whiteMaterial.lightingModel = .physicallyBased
    whiteMaterial.locksAmbientWithDiffuse = true
    
    let grayMaterial = SCNMaterial()
    grayMaterial.diffuse.contents = UIColor.gray
    grayMaterial.metalness.contents = UIColor.gray
    grayMaterial.locksAmbientWithDiffuse = true
    
    let darkGrayMaterial = SCNMaterial()
    darkGrayMaterial.diffuse.contents = UIColor.darkGray
    darkGrayMaterial.locksAmbientWithDiffuse = true

    // white on inside surfaces, gray on outside surfaces, dark grey on thin edges
    corner1.materials = [grayMaterial, grayMaterial, whiteMaterial, darkGrayMaterial, darkGrayMaterial, grayMaterial]
    corner2.materials = [grayMaterial, grayMaterial, darkGrayMaterial, darkGrayMaterial, whiteMaterial, grayMaterial]
    corner3.materials = [grayMaterial, grayMaterial, darkGrayMaterial, whiteMaterial, darkGrayMaterial, grayMaterial]
    corner4.materials = [grayMaterial, grayMaterial, darkGrayMaterial, whiteMaterial, darkGrayMaterial, grayMaterial]
    corner5.materials = [grayMaterial, grayMaterial, darkGrayMaterial, darkGrayMaterial, whiteMaterial, grayMaterial]
    corner6.materials = [grayMaterial, grayMaterial, whiteMaterial, darkGrayMaterial, darkGrayMaterial, grayMaterial]
    
    let box1Node = SCNNode(geometry: corner1)
    box1Node.position = SCNVector3Make(0, Float(l/2)-Float(d/2), Float(l/2)-Float(d/2))
    
    let box2Node = SCNNode(geometry: corner2)
    box2Node.position = SCNVector3Make(0, 0, 0)
    
    let box3Node = SCNNode(geometry: corner3)
    box3Node.position = SCNVector3Make(Float(b/2)-Float(d/2), Float(l/2)-Float(d/2), Float(l/2)-Float(b/2))
    
    let box4Node = SCNNode(geometry: corner4)
    box4Node.position = SCNVector3Make(Float(b/2)-Float(d/2), Float(b/2)-Float(d/2), 0)
    
    let box5Node = SCNNode(geometry: corner5)
    box5Node.position = SCNVector3Make(-Float(l/2)+Float(b/2), 0, Float(l/2)-Float(b/2))
    
    let box6Node = SCNNode(geometry: corner6)
    box6Node.position = SCNVector3Make(-Float(l/2)+Float(b/2), Float(b/2)-Float(d/2), Float(l/2)-Float(d/2))
    
    cornerNode.addChildNode(box1Node)
    cornerNode.addChildNode(box2Node)
    cornerNode.addChildNode(box3Node)
    cornerNode.addChildNode(box4Node)
    cornerNode.addChildNode(box5Node)
    cornerNode.addChildNode(box6Node)

    return cornerNode
}
