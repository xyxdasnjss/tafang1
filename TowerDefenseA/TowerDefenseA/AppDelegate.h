//
//  AppDelegate.h
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright XYXD 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "Level.h"
#import "GameLayer.h"
#import "GameOverLayer.h"
#import "NextLevelScene.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    
    int _curLevelIndex;
    NSMutableArray *_levels;
    GameScene *_mainScene;
    GameOverScene *_gameOverScene;
    NextLevelScene *_nextLevelScene;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@property (nonatomic, assign) int curLevelIndex;
@property (nonatomic, retain) NSMutableArray *levels;
@property (nonatomic, retain) GameScene *mainScene;
@property (nonatomic, retain) GameOverScene *gameOverScene;
@property (nonatomic, retain) NextLevelScene *nextLevelScene;


- (Level *)curLevel;
- (void)nextLevel;
- (void)levelComplete;
- (void)restartGame;
- (void)loadGameOverScene;
- (void)loadWinScene;

@end
