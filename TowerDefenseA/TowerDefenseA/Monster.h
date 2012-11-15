//
//  Monster.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "cocos2d.h"

@interface Monster : CCSprite {
    int _curHp;
    int _totalHp;
    int _minMoveDuration;
    int _maxMoveDuration;
    CCProgressTimer *_healthBar;
    //http://blog.sina.com.cn/s/blog_66116bd90100zvkn.html
}

@property (nonatomic, assign) int curHp;
@property (nonatomic, assign) int totalHp;
@property (nonatomic, assign) int minMoveDuration;
@property (nonatomic, assign) int maxMoveDuration;
@property (nonatomic, retain) CCProgressTimer *healthBar;


@end

@interface WeakAndFastMonster : Monster {
}
+(id)monster;
@end

@interface StrongAndSlowMonster : Monster {
}
+(id)monster;
@end
