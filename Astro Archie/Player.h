//
//  Player.h
//  Astro Archie
//
//  Created by Luke Roberts on 18/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Fuel.h"
#import "Special.h"
#import "Coin.h"
#import "Enemy.h"
#import "assetManager.h"

@interface Player : CCNode {
  CGPoint _velocity;
  float _targetYVelocity;
  float _SpeedOveride;
  int _score;
  float _fuel;
  CCParticleSystem  *flameEmitterLeft;
  CCParticleSystem  *flameEmitterRight;
}
@property(nonatomic, retain)CCSprite *sprite;
@property float height;
-(id)initWithParentNode:(CCNode *)parentNode;
-(void)takeOff;
-(void)didCollideWithObject:(id)object;
-(void)steerArchie;
-(void)incrementScore;
-(int)score;
-(void)decrementFuel;
-(float)getYVelocity;
-(void)setTargetYVelocity:(float)targetVelocity;
-(float)fuel;
-(CGRect)spriteBox;
-(void)didCollectSpecial:(Special*)object;
-(void)increaseHeight;
@end
