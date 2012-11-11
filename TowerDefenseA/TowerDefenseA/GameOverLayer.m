//
//  GameOverLayer.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameLayer.h"
#import "AppDelegate.h"

@implementation GameOverScene
@synthesize layer = _layer;

- (id)init {
    
	if ((self = [super init])) {
		self.layer = [GameOverLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {

	_layer = nil;

}

@end

@implementation GameOverLayer
@synthesize label = _label;

- (void)reset {
    [self runAction:[CCSequence actions:
                     [CCDelayTime actionWithDuration:3],
                     [CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],
                     nil]];
}

-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		self.label = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:32];
		_label.color = ccc3(0,0,0);
		_label.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:_label];
		
	}
	return self;
}

- (void)gameOverDone {
    
	//[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
    AppController *delegate = [[UIApplication sharedApplication] delegate];
    [delegate restartGame];
	
}

- (void)dealloc {

	_label = nil;

}

@end