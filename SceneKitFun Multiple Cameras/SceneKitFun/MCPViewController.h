//
//  MCPViewController.h
//  SceneKitFun
//
//  Created by Jeff LaMarche on 4/21/13.
//  Copyright (c) 2013 Jeff LaMarche. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>

@interface MCPViewController : NSViewController
@property (nonatomic, retain) IBOutlet SCNView *leftSceneView;
@property (nonatomic, retain) IBOutlet SCNView *rightSceneView;
@property (nonatomic, retain) IBOutlet SCNScene *scene;

@end
