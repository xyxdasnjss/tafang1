//
//  HelloWorldLayer.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright XYXD 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class SneakyJoystick;
@class SneakyButton;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    SneakyJoystick *leftJoystick;
	SneakyButton *rightButton;
    
    CCSprite  *spriteBk;
    
    CCSprite  *spriteValue;
    
    float spritecontentSizeWidth;
    float spritecontentSizeHeight;
    
    float i;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
