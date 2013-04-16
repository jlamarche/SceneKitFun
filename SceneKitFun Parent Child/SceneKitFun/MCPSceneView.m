//
//  MCPSceneView.m
//  SceneKitFun
//
//  Created by Jeff LaMarche on 8/17/12.
//  Copyright (c) 2012 Jeff LaMarche. All rights reserved.
//

#define MCP_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import "MCPSceneView.h"

@implementation MCPSceneView
-(void)awakeFromNib
{
    self.backgroundColor = [NSColor grayColor];
    
    // Create an empty scene
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
    
    // Create a camera
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = 45;   // Degrees, not radians
    camera.yFov = 45;
	SCNNode *cameraNode = [SCNNode node];
	cameraNode.camera = camera;
	cameraNode.position = SCNVector3Make(0, 0, 50);
    [scene.rootNode addChildNode:cameraNode];
    
    // Create a torus
    SCNTorus *torus = [SCNTorus torusWithRingRadius:8 pipeRadius:3];
    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
    [scene.rootNode addChildNode:torusNode];
    
    // Create ambient light
    SCNLight *ambientLight = [SCNLight light];
	SCNNode *ambientLightNode = [SCNNode node];
    ambientLight.type = SCNLightTypeAmbient;
	ambientLight.color = [NSColor colorWithDeviceWhite:0.1 alpha:1.0];
	ambientLightNode.light = ambientLight;
    [scene.rootNode addChildNode:ambientLightNode];
    
    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(-30, 30, 50);
	[scene.rootNode addChildNode:diffuseLightNode];
    
    
    // Give the Torus a child
    SCNText *text = [SCNText textWithString:@"Whee!" extrusionDepth:4.f];
    SCNNode *textNode = [SCNNode nodeWithGeometry:text];
    textNode.position = SCNVector3Make(-1, 5, 0);
    textNode.transform = CATransform3DScale(textNode.transform, .1f, .1f, .1f);
    [torusNode addChildNode:textNode];
    
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
    
    
    
}
@end
