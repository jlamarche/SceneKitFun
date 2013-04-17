//
//  MCPSceneView.h
//  SceneKitFun
//
//  Created by Jeff LaMarche on 8/17/12.
//  Copyright (c) 2012 Jeff LaMarche. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>

typedef enum
{
    SceneKitFunPrimitiveTorus,
    SceneKitFunPrimitivePlane,
    SceneKitFunPrimitivePyramid,
    SceneKitFunPrimitiveCapsule,
    SceneKitFunPrimitiveCone,
    SceneKitFunPrimitiveSphere,
    SceneKitFunPrimitiveTube,
    SceneKitFunPrimitiveBox,
    SceneKitFunPrimitiveChamferedBox,
    //SceneKitFunPrimitiveFloor,  Not intended to be rotated


    SceneKitFunPrimitiveCount
    
} SceneKitFunPrimitive;

@interface MCPSceneView : SCNView
@property (nonatomic, retain) SCNNode *currentNode;
@property (nonatomic) SceneKitFunPrimitive currentPrimitive;
@property (nonatomic, retain) NSTimer *timer;
@end
