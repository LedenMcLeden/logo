# logo
*SceneKit project to create 3D logo*

This is a demo SceneKit project composed of three elements:
1. outside box (defined via six SCNBox objects per corner and then combining eight corners)
2. inside sun (defined via a SCNTube object for the circle and UIBezierPath objects per "ray")
3. position of camera

## Project Structure
- GameViewController.swift
  - initialises the View, Scene and Camera
  - func initScene() calls createBox() and createSun()
- makeCorner.swift
  - makeCorner()
- createBox.swift
  - createBox() calls makeCorner() eight times
- createSun.swift
  - createSun()
  
## Functional as of 11th April 2020
- effectively version 1.0
- code compiles and runs
- sun is correctly positioned inside box
- box is truly cubic
- camera is correctly positioned and allowed to be manipulated
- box spins around the sun based on touch input (random spin, not based on touch vectors)

## Development to do
**Major**
- 

**Minor**
- add curvature to sun ray sides - they are drawn using UIBezierPath QuadCurves but currently render with straight lines
- rotate each ray fractionally to line up parallel with sun surface
- change materials of cube to be metallic and reflective - really needs new lighting sources to make this work
- embed in SwiftUI view
