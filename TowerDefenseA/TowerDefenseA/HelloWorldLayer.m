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

#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedJoystickExample.h"
#import "SneakyJoystickSkinnedDPadExample.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "ColoredCircleSprite.h"


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
        
        
        
        
        
        SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
		leftJoy.position = ccp(64,64);
		leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:64];
		leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:32];
		leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
		leftJoystick = leftJoy.joystick;
		[self addChild:leftJoy];
		
		SneakyButtonSkinnedBase *rightBut = [[SneakyButtonSkinnedBase alloc] init];
		rightBut.position = ccp(256,32);
		rightBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 128) radius:32];
		rightBut.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:32];
		rightBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:32];
		rightBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
		rightButton = rightBut.button;
		rightButton.isToggleable = YES;
		[self addChild:rightBut];
        
        
        
        spriteBk = [CCSprite spriteWithFile:@"health_bar_green.png"];
        [self addChild:spriteBk z:2];
        spriteBk.position = ccp(size.width / 2,20);
        spriteValue = [CCSprite spriteWithFile:@"health_bar_red.png"];
        spritecontentSizeWidth = spriteValue.contentSize.width;
        spritecontentSizeHeight = spriteValue.contentSize.height;
        [self addChild:spriteValue z:3];
        spriteValue.anchorPoint = ccp(0,0.5);
        spriteValue.position = ccp(size.width / 2 ,20);
		
        
        
//        [self removeChild:spriteValue cleanup:true];
//        spriteValue = nil;
//        CGRect rect;
//        rect.origin = ccp(0,0);
//        rect.size.width = spritecontentSizeWidth * (30 / 100);
//        rect.size.height = spritecontentSizeHeight;
//        spriteValue = [CCSprite spriteWithFile:@"health_bar_red.png" rect:rect];
//        [self addChild:spriteValue z:3];
//        spriteValue.anchorPoint = ccp(0,0.5);
//        spriteValue.position = ccp(size.width / 2 ,20);
//        i = 0;
        
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
        
        [self scheduleUpdate];

	}
	return self;
}

- (void) update: (ccTime) delta{
    
//    CGPoint pos = sprite.position;
//    pos.x = pos.x + leftJoystick.velocity.x;
//    pos.y = pos.y + leftJoystick.velocity.y;
//    sprite.position = pos;
    
    [self removeChild:spriteValue cleanup:true];
    spriteValue = nil;
    CGRect rect;
    rect.origin = ccp(0,0);
    
    i = i+ leftJoystick.velocity.x;
    if (i>1) {
        i=0;
    }else if(i<0){
        i = 0;
    }
    rect.size.width = spritecontentSizeWidth * i;
    rect.size.height = spritecontentSizeHeight;
    spriteValue = [CCSprite spriteWithFile:@"health_bar_red.png" rect:rect];
    [self addChild:spriteValue z:3];
    spriteValue.anchorPoint = ccp(0,0.5);
    CGSize  size = [[CCDirector sharedDirector] winSize];
    spriteValue.position = ccp(size.width / 2 ,20);
    
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
