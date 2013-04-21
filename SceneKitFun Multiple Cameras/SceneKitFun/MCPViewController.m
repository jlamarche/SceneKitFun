//
//  MCPViewController.m
//  SceneKitFun
//
//  Created by Jeff LaMarche on 4/21/13.
//  Copyright (c) 2013 Jeff LaMarche. All rights reserved.
//

// This project shows how to have two views showing the same scene but using different cameras

#import "MCPViewController.h"
#import <GLKit/GLKit.h>
#import <SceneKit/SceneKit.h>

@interface MCPViewController ()

@end

@implementation MCPViewController

- (void)awakeFromNib
{
    self.leftSceneView.backgroundColor = [NSColor blueColor];
    self.rightSceneView.backgroundColor = [NSColor redColor];
    
    
    // Create an empty scene
    self.scene = [SCNScene scene];
    
    // Create two cameras - one for each scene
    SCNCamera *leftCamera = [SCNCamera camera];
    leftCamera.xFov = 45;   // Degrees, not radians
    leftCamera.yFov = 45;
	SCNNode *leftCameraNode = [SCNNode node];
	leftCameraNode.camera = leftCamera;
    CATransform3D cameraRot = CATransform3DMakeRotation(GLKMathDegreesToRadians(90), 0, 1, 0);
    leftCameraNode.transform = cameraRot;
	leftCameraNode.position = SCNVector3Make(30, 0, 0);
    [self.scene.rootNode addChildNode:leftCameraNode];
    
    SCNCamera *rightCamera = [SCNCamera camera];
    rightCamera.xFov = 60;   // Degrees, not radians
    rightCamera.yFov = 60;
	SCNNode *rightCameraNode = [SCNNode node];
	rightCameraNode.camera = rightCamera;
	rightCameraNode.position = SCNVector3Make(0, 0, 30);
    [self.scene.rootNode addChildNode:rightCameraNode];
    

    // Create a torus
    SCNTorus *torus = [SCNTorus torusWithRingRadius:8 pipeRadius:3];
    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
    CATransform3D rot = CATransform3DMakeRotation(GLKMathDegreesToRadians(45), 1, 0, 0);
    torusNode.transform = rot;
    [self.scene.rootNode addChildNode:torusNode];
    
    
    // Create ambient light
    SCNLight *ambientLight = [SCNLight light];
	SCNNode *ambientLightNode = [SCNNode node];
    ambientLight.type = SCNLightTypeAmbient;
	ambientLight.color = [NSColor colorWithDeviceWhite:0.1 alpha:1.0];
	ambientLightNode.light = ambientLight;
    [self.scene.rootNode addChildNode:ambientLightNode];
    
    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(-30, 30, 50);
	[self.scene.rootNode addChildNode:diffuseLightNode];
    
    
    // Give the Torus an image-based diffuse and a normal map
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents  = [NSColor blueColor];
    NSImage *normalImage = [NSImage imageNamed:@"noise_normal"];
    material.normal.contents = normalImage;
    material.specular.contents = [NSColor whiteColor];
    material.shininess = 1.0;
    torus.materials = @[material];
    
    // Animate the torus
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation.duration = 3.f;
    animation.repeatCount = HUGE_VALF;


    [torusNode addAnimation:animation forKey:@"transform"];
    
    // Assign the cameras to the scene
    self.leftSceneView.scene = self.scene;
    self.rightSceneView.scene = self.scene;
    
    // Tell each view which camera in the scene to use
    self.leftSceneView.pointOfView = leftCameraNode;
    self.rightSceneView.pointOfView = rightCameraNode;
}

@end
