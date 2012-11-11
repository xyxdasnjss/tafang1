//
//  NewLevelScene.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-11.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextLevelLayer : CCLayerColor {
}

-(void)reset;

@end

@interface NextLevelScene : CCScene {
	NextLevelLayer *_layer;
}

@property (nonatomic, retain) NextLevelLayer *layer;

@end
