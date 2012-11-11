//
//  GameLayer.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
@interface GameLayer : CCLayerColor
{
    CCSprite *_hero;//
    CCSprite *_curBg;
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    int _projectilesDestroyed;
    
    CCSprite *_nextProjectile;
    int _score;
    int _oldScore;
    CCLabelTTF *_scoreLabel;
    
}

- (void)reset;
@property (nonatomic, retain) CCSprite *curBg;
@property (nonatomic, retain) CCLabelTTF *scoreLabel;
@property (nonatomic, retain) CCSprite *nextProjectile;



@end

@interface GameScene : CCScene
{
    GameLayer *_layer;
}

@property (nonatomic, retain) GameLayer *layer;

+ (id) scene;

@end
