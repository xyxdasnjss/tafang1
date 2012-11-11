//
//  NewLevelScene.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "NextLevelScene.h"
#import "GameLayer.h"
#import "AppDelegate.h"

@implementation NextLevelScene
@synthesize layer = _layer;

- (id)init {
    
	if ((self = [super init])) {
		self.layer = [NextLevelLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	
	_layer = nil;

}

@end

@implementation NextLevelLayer

- (void)reset {
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:3],
                     [CCCallFunc actionWithTarget:self selector:@selector(newLevelDone)],
                     nil]];
}

-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Get Ready!!" fontName:@"Arial" fontSize:32];
		label.color = ccc3(0,0,0);
		label.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:label];
		
	}
	return self;
}

- (void)nextLevelDone {
    
    AppController *delegate = [[UIApplication sharedApplication] delegate];
    [delegate nextLevel];
	
}



@end