//
//  HelloWorldLayer.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright XYXD 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "GameLayer.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"xtz.plist"];
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"xtz.png"];
        
		
        CCSprite *animating = [CCSprite spriteWithSpriteFrameName:@"xtz0.jpg"];
        [animating setPosition:ccp(200, 200)];
        [batchNode addChild:animating];
        [self addChild:batchNode];
        
        
        CCAnimation *anim = [CCAnimation animation];
//        [anim addSpriteFrameWithFilename:@"xtz1.jpg"];
//        [anim addSpriteFrameWithFilename:@"xtz2.jpg"];
//        [anim addSpriteFrameWithFilename:@"xtz3.jpg"];
        
        [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xtz1.jpg"]];
        [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xtz2.jpg"]];
        [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xtz3.jpg"]];
        [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xtz4.jpg"]];
        [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"xtz5.jpg"]];
        
        
        anim.restoreOriginalFrame = YES;
        anim.delayPerUnit = .5;
        

        
        id animAction = [CCAnimate actionWithAnimation:anim];

        id repeatAnimation = [CCRepeatForever actionWithAction:animAction];
        
        [animating runAction:repeatAnimation];
        

//        
//        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"myTestAnimation"];
//        
//        CCAnimation *myTestAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"myTestAnimation"];
//
        CCSprite *xtz0 = [CCSprite spriteWithSpriteFrameName:@"xtz0.jpg"];
        xtz0.position = ccp(0, 0);
        [self addChild:xtz0];
        CCAction *moveAction = [CCMoveBy actionWithDuration:3 position:ccp(size.width, size.height)];
        [xtz0 runAction:moveAction];
        
		
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Achievement Menu Item using blocks
		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"开始" block:^(id sender) {
			
//			GameLayer *game = GameLayer
            
            [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
			
		}
									   ];

		// Leaderboard Menu Item using blocks
		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
			
			
			
		}
									   ];
		
		CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
}

// on "dealloc" you need to release all your retained objects

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
