//
//  GameOverLayer.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    CCLabelTTF *_label;
}

- (void)reset;
@property (nonatomic, strong) CCLabelTTF *label;
@end

@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property (nonatomic, strong) GameOverLayer *layer;
@end
