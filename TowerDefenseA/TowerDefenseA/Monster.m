//
//  Monster.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "Monster.h"

@implementation Monster

@synthesize curHp = _curHp;
@synthesize totalHp = _totalHp;
@synthesize minMoveDuration = _minMoveDuration;
@synthesize maxMoveDuration = _maxMoveDuration;
@synthesize healthBar = _healthBar;


-(void)healthBarLogic:(ccTime)dt {
    
    //Update health bar pos and percentage.
    _healthBar.position = ccp(self.position.x, (self.position.y+20));
    _healthBar.percentage = ((float)self.curHp/(float)self.totalHp) *100;
    if (_healthBar.percentage <= 0) {
        [self removeChild:_healthBar cleanup:YES];
    }
}

@end

@implementation WeakAndFastMonster

+ (id)monster {
    
    WeakAndFastMonster *monster = nil;
    if ((monster = [[super alloc] initWithFile:@"Icon.png"])) {
        monster.curHp = monster.totalHp = 1;
        monster.minMoveDuration = 3;
        monster.maxMoveDuration = 5;
        
//        CCSprite *bar = [CCSprite spriteWithFile:@"health_bar_red.png"];
//        monster.healthBar = [CCProgressTimer progressWithSprite:bar];
//        monster.healthBar.type = kCCProgressTimerTypeBar;
//        monster.healthBar.percentage = 100;
//        [monster.healthBar setScale:0.5];
//        monster.healthBar.position = ccp(monster.position.x,(monster.position.y+20));
//        [monster addChild:monster.healthBar z:3];
        
        [monster schedule:@selector(healthBarLogic:)];
        
    }
    return monster;
    
}

@end

@implementation StrongAndSlowMonster

+ (id)monster {
    
    StrongAndSlowMonster *monster = nil;
    if ((monster = [[super alloc] initWithFile:@"Target.png"])) {
        monster.curHp = monster.totalHp = 3;
        monster.minMoveDuration = 6;
        monster.maxMoveDuration = 12;
        
//        CCSprite *bar = [CCSprite spriteWithFile:@"health_bar_red.png"];
//        monster.healthBar = [CCProgressTimer progressWithSprite:bar];
//        monster.healthBar.type = kCCProgressTimerTypeBar;
//        monster.healthBar.percentage = 100;
//        [monster.healthBar setScale:0.5];
//        monster.healthBar.position = ccp(monster.position.x,(monster.position.y+20));
//        [monster addChild:monster.healthBar z:3];
        
        [monster schedule:@selector(healthBarLogic:)];
    }
    return monster;
    
}

@end
