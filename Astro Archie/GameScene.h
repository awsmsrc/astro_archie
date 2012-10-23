//
//  GameScene.h
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuScene.h"
#import "Player.h"
#import "CoinManager.h"

@interface GameScene : CCLayer {
  CCLayer *gameLayer;
  CCLayer *hudLayer;
  CGSize screenSize;
  CCLabelTTF *scoreLabel;
  CCSprite *bg;
  BOOL _pauseScreenUp;
  CCMenu *_pauseScreenMenu;
  CCLayer *pauseLayer;
  Player *player;
  CCProgressTimer* fuel;
}

@property(nonatomic, retain)CoinManager *coinManager;

+(id)scene;
-(void)beginGameplay;
-(void)setUpScene;
-(void)increaseAltitude;
-(void)startScoreTimer;

@end
