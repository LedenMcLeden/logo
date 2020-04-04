//
//  createCube.swift
//  logo
//
//  Created by Dane Muldoon on 5/4/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

func createCube() -> SCNNode {
        let boxNode = SCNNode()
        
        let breadth: CGFloat = 1
        let length: CGFloat = 3
        let depth: CGFloat = 0.1
        let cubeSide: Float = 10
        let adjust: Float = 1.5
        let small: Float = 0.5
        
        let corner1 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner1.position = SCNVector3Make(0, 0, 0)
        boxNode.addChildNode(corner1)
        
        let corner2 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner2.rotation = SCNVector4Make(1, 0, 0, .pi/2)
        corner2.position = SCNVector3Make(0, adjust, -cubeSide)
        boxNode.addChildNode(corner2)
        
        let corner3 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner3.rotation = SCNVector4Make(0, 0, 1, .pi/2)
        corner3.position = SCNVector3Make(small, cubeSide+adjust, 0)
        boxNode.addChildNode(corner3)
        
        let corner4 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner4.rotation = SCNVector4Make(1, 0, 0, .pi)
        corner4.position = SCNVector3Make(0, cubeSide+adjust+small, -cubeSide+adjust)
        boxNode.addChildNode(corner4)
        
        let corner5 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner5.rotation = SCNVector4Make(0, 1, 0, -.pi/2)
        corner5.position = SCNVector3Make(-cubeSide, 0, adjust-small)
        boxNode.addChildNode(corner5)
        
        let corner6 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner6.rotation = SCNVector4Make(0, 0, 1, .pi)
        corner6.position = SCNVector3Make(-cubeSide-adjust+small, cubeSide+adjust+small, 0)
        boxNode.addChildNode(corner6)
        
        let corner7 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner7.rotation = SCNVector4Make(1, 1, 0, .pi)
        corner7.position = SCNVector3Make(-cubeSide-adjust, cubeSide+adjust, -cubeSide+adjust)
        boxNode.addChildNode(corner7)
        
        let corner8 = makeCorner(breadth: breadth, length: length, depth: depth)
        corner8.rotation = SCNVector4Make(0, 1, 0, -.pi)
        corner8.position = SCNVector3Make(-cubeSide-adjust, 0, -cubeSide+adjust)
        boxNode.addChildNode(corner8)

        boxNode.position = SCNVector3Make(cubeSide/2+adjust/2, -cubeSide/2-adjust/2, cubeSide/2-adjust/2)
                
        return boxNode
    }
