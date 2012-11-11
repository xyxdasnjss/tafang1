//
//  Projectile.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile
@synthesize monstersHit = _monstersHit;

- (Projectile*)initWithFile:(NSString *)file {
    if ((self = [super initWithFile:file])) {
        self.monstersHit = [NSMutableArray array];
    }
    return self;
}

- (BOOL)shouldDamageMonster:(CCSprite *)monster {
    if ([_monstersHit containsObject:monster]) {
        return FALSE;
    }
    else {
        [_monstersHit addObject:monster];
        return TRUE;
    }
}

- (void) dealloc
{
    self.monstersHit = nil;
   
}

@end
