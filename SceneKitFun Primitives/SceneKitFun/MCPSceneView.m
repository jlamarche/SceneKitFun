//
//  MCPSceneView.m
//  SceneKitFun
//
//  Created by Jeff LaMarche on 8/17/12.
//  Copyright (c) 2012 Jeff LaMarche. All rights reserved.
//


#define MCP_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import "MCPSceneView.h"
#import <QuartzCore/QuartzCore.h>




@interface MCPSceneView()
- (void)useNextPrimitive;
@end


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
	cameraNode.position = SCNVector3Make(0, 0, 30);
    [scene.rootNode addChildNode:cameraNode];
    

    [self useNextPrimitive];
    
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
}
- (void)timerFired:(NSTimer*)theTime
{
    [self useNextPrimitive];
}
- (void)useNextPrimitive
{
    
    if (self.currentNode != nil)
    {
        [self.currentNode removeFromParentNode];
        self.currentNode = nil;
    }
    SCNGeometry *geom = nil;
    
    switch (_currentPrimitive++)
    {
        case SceneKitFunPrimitiveTorus:
        {
            SCNTorus *torus = [SCNTorus torusWithRingRadius:8 pipeRadius:3];
            geom = torus;
            break;
        }
        case SceneKitFunPrimitivePlane:
        {
            SCNPlane *plane = [SCNPlane planeWithWidth:10 height:10];
            geom = plane;
            break;
        }
        case SceneKitFunPrimitivePyramid:
        {
            SCNPyramid *pyramid = [SCNPyramid pyramidWithWidth:10 height:10 length:10];
            geom = pyramid;
            break;
        }
//        case SceneKitFunPrimitiveFloor:
//        {
//            SCNFloor *floor = [SCNFloor floor];
//            geom = floor;
//        }
        case SceneKitFunPrimitiveCapsule:
        {
            SCNCapsule *capsule = [SCNCapsule capsuleWithCapRadius:2 height:13];
            geom = capsule;
            break;
        }
        case SceneKitFunPrimitiveCone:
        {
            SCNCone *cone = [SCNCone coneWithTopRadius:0 bottomRadius:6 height:10];
            geom = cone;
            break;
        }
        case SceneKitFunPrimitiveSphere:
        {
            SCNSphere *sphere = [SCNSphere sphereWithRadius:8];
            geom = sphere;
            break;
        }
        case SceneKitFunPrimitiveTube:
        {
            SCNTube *tube = [SCNTube tubeWithInnerRadius:4 outerRadius:8 height:3];
            geom = tube;
            break;
        }
        case SceneKitFunPrimitiveBox:
        {
            SCNBox *box = [SCNBox boxWithWidth:8 height:8 length:8 chamferRadius:0];
            geom = box;
            break;
        }
        case SceneKitFunPrimitiveChamferedBox:
        {
            SCNBox *box = [SCNBox boxWithWidth:8 height:8 length:8 chamferRadius:.3];
            geom = box;
            break;
        }
        default:
            break;
    }
    
    if (_currentPrimitive >= SceneKitFunPrimitiveCount) self.currentPrimitive = SceneKitFunPrimitiveTorus;
    

    SCNNode *node = [SCNNode nodeWithGeometry:geom];
    CATransform3D rot = CATransform3DMakeRotation(MCP_DEGREES_TO_RADIANS(45), 1, 0, 0);
    node.transform = rot;
    self.currentNode = node;
    [self.scene.rootNode addChildNode:node];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(node.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(node.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(node.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(node.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(node.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation.duration = 3.f;
    animation.repeatCount = HUGE_VALF;
    
    
    [node addAnimation:animation forKey:@"transform"];

    
}
@end
