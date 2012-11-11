//
//  Projectile.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "CCSprite.h"

@interface Projectile : CCSprite {
    NSMutableArray *_monstersHit;
}

@property (nonatomic, retain) NSMutableArray *monstersHit;

- (Projectile*)initWithFile:(NSString *)file;
- (BOOL)shouldDamageMonster:(CCSprite *)monster;

@end
