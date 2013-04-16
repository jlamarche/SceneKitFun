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

-(void)loadScene
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Bendy" withExtension:@"dae"];
    
    
    NSError * __autoreleasing error;
    SCNScene *scene = [SCNScene sceneWithURL:url options:nil error:&error];
    if (scene)
        self.scene = scene;
    else
        NSLog(@"Yikes!");
    
    
    self.jitteringEnabled = YES;
    self.allowsCameraControl = YES;
    self.playing = YES;
}
-(void)awakeFromNib
{
    self.backgroundColor = [NSColor grayColor];
    [self loadScene];
    

    
}
@end
