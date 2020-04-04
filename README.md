# logo
*SceneKit project to create 3D logo*

This is a demo SceneKit project composed of three elements:
1. outside box (defined via six SCNBox objects per corner and then combining eight corners)
2. inside sun (defined via a SCNTube object for the circle and UIBezierPath objects per "ray")
3. position of camera

## Project Structure
- GameViewController.swift
  - initialises the View, Scene and Camera
  - func initScene() calls createCube() and createSun()
- makeCorner.swift
  - makeCorner()
- createCube.swift
  - createCube() calls makeCorner() eight times
- createSun.swift
  - createSun()
  
## Functional as of 5th April 2020
- code compiles and runs
- sun is positioned inside cube
- view can be spun by manipulating the camera view

## Development to do
**Major**
- fix camera in correct position
- allow cube to spin freely around the fixed sun
- change materials of cube to be metallic and reflective
**Minor**
- add curvature to sun ray sides - they are drawn using UIBezierPath QuadCurves but currently render with straight lines
- rotate each ray fractionally to line up parallel with sun surface
