//
//  Level.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
    int _levelNum;
    float _spawnRate;
    NSString *_bgImageName;
}

@property (nonatomic, assign) int levelNum;
@property (nonatomic, assign) float spawnRate;
@property (nonatomic, copy) NSString *bgImageName;

- (id)initWithLevelNum:(int)levelNum spawnRate:(float)spawnRate bgImageName:(NSString *)bgImageName;

@end
