//
//  Monster.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "Monster.h"

@implementation Monster

@synthesize hp = _curHp;
@synthesize minMoveDuration = _minMoveDuration;
@synthesize maxMoveDuration = _maxMoveDuration;

@end

@implementation WeakAndFastMonster

+ (id)monster {
    
    WeakAndFastMonster *monster = nil;
    if ((monster = [[super alloc] initWithFile:@"Icon.png"])) {
        monster.hp = 1;
        monster.minMoveDuration = 3;
        monster.maxMoveDuration = 5;
    }
    return monster;
    
}

@end

@implementation StrongAndSlowMonster

+ (id)monster {
    
    StrongAndSlowMonster *monster = nil;
    if ((monster = [[super alloc] initWithFile:@"Icon.png"])) {
        monster.hp = 3;
        monster.minMoveDuration = 6;
        monster.maxMoveDuration = 12;
    }
    return monster;
    
}

@end
