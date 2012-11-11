//
//  Level.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "Level.h"

@implementation Level

@synthesize spawnRate = _spawnRate;
@synthesize levelNum = _levelNum;
@synthesize bgImageName = _bgImageName;

- (id)initWithLevelNum:(int)levelNum spawnRate:(float)spawnRate bgImageName:(NSString *)bgImageName {
    
    if ((self = [super init])) {
        self.levelNum = levelNum;
        self.spawnRate = spawnRate;
        self.bgImageName = bgImageName;
    }
    
    return self;
    
}

@end
