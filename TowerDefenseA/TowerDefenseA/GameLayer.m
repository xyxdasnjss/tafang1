//
//  GameLayer.m
//  TowerDefenseA
//
//  Created by xyxd on 12-11-10.
//  Copyright (c) 2012年 XYXD. All rights reserved.
//

#import "GameLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"
#import "Monster.h"
#import "AppDelegate.h"
#import "Projectile.h"
@implementation GameScene

@synthesize layer = _layer;

+(id) scene
{
	// 'scene' is an autorelease object.
	GameScene *scene = [GameScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
    scene.layer = layer;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) dealloc
{
    self.layer = nil;
}

@end

@interface GameLayer ()
{
    int i;
}
@end
@implementation GameLayer
@synthesize curBg = _curBg;
@synthesize scoreLabel = _scoreLabel;
@synthesize nextProjectile = _nextProjectile;


//
-(id) init
{
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)])) {
        
     
        // Enable touch events
		self.touchEnabled = YES;
		
		// Initialize arrays
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		// Add the player to the middle of the screen along the y-axis,
		// and as close to the left side edge as we can get
		// Remember that position is based on the anchor point, and by default the anchor
		// point is the middle of the object.
		_hero = [CCSprite spriteWithFile:@"Player2.png"];
		_hero.position = ccp(_hero.contentSize.width/2 + 100, winSize.height/2);
		[self addChild:_hero z:1];
        
        // Set up score and score label
        _score = 0;
        _oldScore = -1;
        
        self.scoreLabel = [CCLabelTTF labelWithString:@"score" fontName:@"Marker Felt" fontSize:32 dimensions:CGSizeMake(100, 50) hAlignment:UITextAlignmentRight];

        _scoreLabel.position = ccp(winSize.width - _scoreLabel.contentSize.width/2, _scoreLabel.contentSize.height/2);
        _scoreLabel.color = ccc3(0,0,0);
        [self addChild:_scoreLabel z:1];
        
        // Useful for taking screenshots
        //[[CCScheduler sharedScheduler] setTimeScale:0.1];
		
		// Call game logic about every second
        [self schedule:@selector(update:)];
		[self schedule:@selector(gameLogic:) interval:1.0];
        
		// Start up the background music
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
    }
	
	return self;
}

- (void) dealloc
{
  
    _targets = nil;
    _projectiles = nil;
    _hero = nil;
    
  
}

-(void)gameLogic:(ccTime)dt {
    static double lastTimeTargetAdded = 0;
    double now = [[NSDate date] timeIntervalSince1970];
    AppController *delegate = [[UIApplication sharedApplication] delegate];
    if(lastTimeTargetAdded == 0 || now - lastTimeTargetAdded >= delegate.curLevel.spawnRate) {
        [self addTarget];
        lastTimeTargetAdded = now;
    }
}


-(void)addTarget {
    
    Monster *target = nil;
    if ((arc4random() % 2) == 0) {
        target = [WeakAndFastMonster monster];
    } else {
        target = [StrongAndSlowMonster monster];
    }
    target.curHpLabel.position = target.position;
    
    // Determine where to spawn the target along the Y axis
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = target.contentSize.height/2;
    int maxY = winSize.height - target.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the target slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
    [self addChild:target];
    [self addChild:target.curHpLabel];
    
    // Determine speed of the target
    int minDuration = target.minMoveDuration;
    int maxDuration = target.maxMoveDuration;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                        position:ccp(-target.contentSize.width/2, actualY)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    // Add to targets array
	target.tag = 1;
	[_targets addObject:target];
}

-(void)spriteMoveFinished:(id)sender {
    
    
    CCSprite *sprite = (CCSprite *)sender;
     [self removeChild:sprite cleanup:YES];
    if (sprite.tag == 1) {
        [_targets removeObject:sprite];
        
        i++;
        CCLOG(@"被击中%d",i);
        if (i==10) {
            i = 0;
            
            AppController *delegate = [[UIApplication sharedApplication] delegate];
            [delegate loadGameOverScene];
        }
        
        
        
    }else if (sprite.tag == 2){
        [_projectiles removeObject:sprite];
    }
   
}

-(void)reset {
    
    // Clear out any objects
    for (CCSprite *target in _targets) {
        [self removeChild:target cleanup:YES];
    }
    [_targets removeAllObjects];
    for (CCSprite *projectile in _projectiles) {
        [self removeChild:projectile cleanup:YES];
    }
    [_projectiles removeAllObjects];
    
    // Remove old bg if it exists
    if (_curBg != nil) {
        [self removeChild:_curBg cleanup:YES];
        self.curBg = nil;
    }
    
    // Add new bg
//    AppController *delegate = [[UIApplication sharedApplication] delegate];
//    CCSprite *bg = [CCSprite spriteWithFile:delegate.curLevel.bgImageName];
//    bg.position = ccp(240,160);
//    [self addChild:bg];
    
    // Store reference to current background so we can remove it on next reset
//    self.curBg = bg;
    
    // Reset stats
    _projectilesDestroyed = 0;
    self.nextProjectile = nil;
    
    // Start up timers again
    self.touchEnabled = YES;
    [self schedule:@selector(update:)];
    [self schedule:@selector(gameLogic:) interval:1.0];
    
    // Don't forget to reset score!  (via @Mark W)
    _score = 0;
    _oldScore = -1;
    
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_nextProjectile != nil) return;
    
    //
    // Easier method using Cocos2D helper functions, suggested by
    // Caleb Wren - see comments for post
    //
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Play a sound!
    [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
    
    // Set up initial location of projectile
    //CGSize winSize = [[CCDirector sharedDirector] winSize];
    self.nextProjectile = [[Projectile alloc] initWithFile:@"Projectile2.png"];
    _nextProjectile.position = _hero.position;
    
    // Rotate player to face shooting direction
    CGPoint shootVector = ccpSub(location, _nextProjectile.position);
    CGFloat shootAngle = ccpToAngle(shootVector);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle);
    
    CGFloat curAngle = _hero.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;
    if (rotateDiff > 180)
		rotateDiff -= 360;
	if (rotateDiff < -180)
		rotateDiff += 360;
    CGFloat rotateSpeed = 0.5 / 180; // Would take 0.5 seconds to rotate half a circle
    CGFloat rotateDuration = fabs(rotateDiff * rotateSpeed);
    
    // Move player slightly backwards
    //CGPoint position = ccpAdd(_player.position, ccp(-10, 0));
    
    [_hero runAction:[CCSequence actions:
                        //[CCMoveBy actionWithDuration:0.1 position:ccp(-10, 0)],
                        [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
                        [CCCallFunc actionWithTarget:self selector:@selector(finishShoot)],
                        nil]];
    
    // Move projectile offscreen
    ccTime delta = 1.0;
    CGPoint normalizedShootVector = ccpNormalize(shootVector);
    CGPoint overshotVector = ccpMult(normalizedShootVector, 420);
    CGPoint offscreenPoint = ccpAdd(_nextProjectile.position, overshotVector);
    
    [_nextProjectile runAction:[CCSequence actions:
                                [CCMoveTo actionWithDuration:delta position:offscreenPoint],
                                [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                                nil]];
    
    // Add to projectiles array
    _nextProjectile.tag = 2;
    
}

- (void)finishShoot {
    
    // Ok to add now - we've finished rotation!
    [self addChild:_nextProjectile];
    [_projectiles addObject:_nextProjectile];
    
    // Release
    _nextProjectile = nil;
    
}

- (void)update:(ccTime)dt {
    
    //需删除的 子弹
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    //所有的 子弹
    for (Projectile *projectile in _projectiles) {
        //子弹的 Rect
        CGRect projectileRect = CGRectMake(
                                           projectile.position.x - (projectile.contentSize.width/2),
                                           projectile.position.y - (projectile.contentSize.height/2),
                                           projectile.contentSize.width,
                                           projectile.contentSize.height);
        BOOL monsterHit = NO;
        //需删除的 敌人
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *target in _targets) {
            //敌人的 rect
            CGRect targetRect = CGRectMake(
                                           target.position.x - (target.contentSize.width/2),
                                           target.position.y - (target.contentSize.height/2),
                                           target.contentSize.width,
                                           target.contentSize.height);
            //碰撞检测
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                
                if (![projectile shouldDamageMonster:target]) {
                    continue;
                }
//                [targetsToDelete addObject:target];
                monsterHit = YES;
                Monster *monster = (Monster *)target;
                monster.hp--;
                [monster.curHpLabel setString:[NSString stringWithFormat:@"%d",monster.hp]];
                if (monster.hp <= 0) {
                    _score ++ ;
                    [targetsToDelete addObject:target];
                }
                break;
            }
        }
        
        //删除 碰撞后的 敌人
        for (CCSprite *target in targetsToDelete) {
            [_targets removeObject:target];
            [self removeChild:target cleanup:YES];
            _projectilesDestroyed++;
			if (_projectilesDestroyed > 10) {
                NSLog(@"Level Up");
                AppController *delegate = [[UIApplication sharedApplication] delegate];
                [delegate levelComplete];
            }
        }
        
        if (monsterHit) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.caf"];
        }
        
//        //>0剩下的就是 子弹了
//        if (targetsToDelete.count > 0) {
////            [projectilesToDelete addObject:projectile];
//            if (monsterHit) {
//                [projectilesToDelete addObject:projectile];
//                [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.caf"];
//            }
//        }
    }
    
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    
    if (_score != _oldScore) {
        _oldScore = _score;
        [_scoreLabel setString:[NSString stringWithFormat:@"%d", _score]];
    }

    
}

@end
