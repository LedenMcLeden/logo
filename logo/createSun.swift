//
//  createSun.swift
//  logo
//
//  Created by Dane Muldoon on 5/4/20.
//  Copyright © 2020 Dane Muldoon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

func createSun() -> SCNNode {
    let sunNode = SCNNode()
    
    // define materials
    // 1.0, 0.9490196078, 0.0 RGB
    let yellowMaterial = SCNMaterial()
    yellowMaterial.diffuse.contents = UIColor(displayP3Red: 1, green: 0.9490196078, blue: 0, alpha: 1)
    yellowMaterial.locksAmbientWithDiffuse = true
    
    // 0.8039215686, 0.1254901961, 0.1529411765 RGB
    let redMaterial = SCNMaterial()
    redMaterial.diffuse.contents = UIColor(displayP3Red: 0.8039215686, green: 0.1254901961, blue: 0.1529411765, alpha: 1)
    redMaterial.locksAmbientWithDiffuse = true
    
    
    // create centre of sun
    let sunBody: SCNGeometry = SCNTube(innerRadius: 0, outerRadius: 4.2, height: 0.1)
    sunBody.materials = [yellowMaterial]
    let sunBodyNode = SCNNode(geometry: sunBody)
    sunNode.addChildNode(sunBodyNode)
    
    
    // draw one sun ray - currently straight lines but the intention is to give the rays a degree of curvature
    let rayPath = UIBezierPath()
    rayPath.move(to: CGPoint(x: 0, y: 0))
    rayPath.addQuadCurve(to: CGPoint(x:0.605768, y:0), controlPoint: CGPoint(x:0.302884, y:0.2))
    rayPath.addQuadCurve(to: CGPoint(x:0.302884, y:1), controlPoint: CGPoint(x:0.605768, y:0.4))
    rayPath.addQuadCurve(to: CGPoint(x:0, y:0), controlPoint: CGPoint(x:0, y:0.4))
    let ray = SCNShape(path: rayPath, extrusionDepth: 0.1)
    //ray.subdivisionLevel = 100    // hilariously turns the ray into a mango seed
    ray.materials = [redMaterial]
    
    // define some matrices for transform purposes
    var rotation: Float = 0.0
    var fixRotationValue: Float = 0.0
    var matrix1: SCNMatrix4
    var matrix2: SCNMatrix4
    var spin90X: SCNMatrix4
    var fixRotationInY: SCNMatrix4
    
    spin90X = SCNMatrix4(m11: 1,    m12: 0,           m13: 0,           m14: 0,
                         m21: 0,    m22: cos(.pi/2),  m23: sin(.pi/2),  m24: 0,
                         m31: 0,    m32: -sin(.pi/2), m33: cos(.pi/2),  m34: 0,
                         m41: 0,    m42: 0,           m43: 0,           m44: 1)
    
    // move ray from centre to edge of sun
    matrix2 = SCNMatrix4(m11: 1.5,        m12: 0,     m13: 0,          m14: 0,
                         m21: 0,          m22: 1.5,   m23: 0,          m24: 0,
                         m31: 0,          m32: 0,     m33: 1,          m34: 0,
                         m41: 0,          m42: 4.6,   m43: 0,          m44: 1)
    
    fixRotationValue = 0.1745329252 // 0.1745329252 is 10° in radians
    fixRotationInY = SCNMatrix4(m11: cos(fixRotationValue),   m12: 0, m13: -sin(fixRotationValue),   m14: 0,
                                m21: 0,                      m22: 1, m23: 0,                        m24: 0,
                                m31: sin(fixRotationValue),  m32: 0, m33: cos(fixRotationValue),    m34: 0,
                                m41: 0,                      m42: 0, m43: 0,                        m44: 1)
    
    for i in 1..<13 {   // 12 rays
        let rayNode = SCNNode(geometry: ray)
        let rotationCorrection: Float = 0.17 // correct for symmetry
        // rotation around the edge of the sun
        rotation = ((.pi*2))/12*Float(i)+rotationCorrection
        // matrix1 is to rotate in Y
        matrix1 = SCNMatrix4(m11: cos(rotation),    m12: 0,     m13: -sin(rotation),   m14: 0,
                             m21: 0,                m22: 1,     m23: 0,                m24: 0,
                             m31: sin(rotation),    m32: 0,     m33: cos(rotation),    m34: 0,
                             m41: 0,                m42: 0,     m43: 0,                m44: 1)
        
        // fixRotationInY is to try and square up the rays to the sun edge but currently not being used
        fixRotationInY = SCNMatrix4Mult(fixRotationInY, spin90X)

        // lay ray down then rotate it around the y axis
        matrix1 = SCNMatrix4Mult(spin90X, matrix1)
        
        // move ray out to the edge of the sun
        matrix1 = SCNMatrix4Mult(matrix2, matrix1)
        
        rayNode.transform = SCNMatrix4Mult(SCNMatrix4Identity, matrix1)
        
        sunNode.addChildNode(rayNode)
    }
        
    // reuse matrix2 to scale the entire sun down in X & Y
    matrix2 = SCNMatrix4(m11: 0.95,  m12: 0,     m13: 0,  m14: 0,
                         m21: 0,     m22: 0.95,  m23: 0,  m24: 0,
                         m31: 0,     m32: 0,     m33: 1,  m34: 0,
                         m41: 0,     m42: 0,     m43: 0,  m44: 1)
    
    // orient sun into correct position with respect to the cube
    sunNode.transform = SCNMatrix4Mult(spin90X, matrix2)
    sunNode.name = "sun"
    
    let pivotXoffset: Float = 7
    let pivotYoffset: Float = -6
    let pivotZoffset: Float = -1
    sunNode.position = SCNVector3Make(pivotXoffset, pivotYoffset, pivotZoffset)
    
    return sunNode
}
