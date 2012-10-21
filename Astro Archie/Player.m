//
//  Player.m
//  Astro Archie
//
//  Created by Luke Roberts on 18/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "SimpleAudioEngine.h" 


@implementation Player

-(id)initWithParentNode:(CCNode *)parentNode
{
  if(self = [super init]){
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    _sprite = [CCSprite spriteWithFile:@"archie.png"];
    float imageHeight = [_sprite texture].contentSize.height;
    _sprite.position = CGPointMake(screenSize.width/2, imageHeight/2);
    [parentNode addChild:self];
    [self addChild:_sprite z:0 tag:1];
  }
  return self;
}

-(void)takeOff
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  CCSequence *seq = [CCSequence actions:
                    [CCDelayTime actionWithDuration:1.2],
                    [CCCallFunc actionWithTarget:self selector:@selector(takeOffSFX)],
                    [CCMoveTo actionWithDuration:0.35 position:ccp(_sprite.position.x, _sprite.position.y + screenSize.height/5)],
                    [CCCallFunc actionWithTarget:self.parent.parent selector:@selector(beginGameplay)],
                    [CCCallFunc actionWithTarget:self selector:@selector(scheduleUpdate)],
                    nil];
  [_sprite runAction:seq];
}

-(void)takeOffSFX
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"Explosion with Metal Debris.wav"];
}

-(void)applyAcceleration:(UIAcceleration *)acceleration
{
  float deceleration = 0.2f;
  float sensitivity = 8.0f;
  float maxVelocity = 80;
  _velocity.x = _velocity.x * deceleration + acceleration.x * sensitivity;
  if(_velocity.x > maxVelocity){
    _velocity.x = maxVelocity;
  }else if(_velocity.x < - maxVelocity){
    _velocity.x = -maxVelocity;
  }
}

-(void)update:(ccTime)delta
{
  [self steerArchie];
}

-(void)steerArchie
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  CGPoint pos = _sprite.position;
  pos.x += _velocity.x;
  //limit the player from leaving the screen
  float imageWidthHalved = [_sprite texture].contentSize.width *0.5f;
  float leftBorderLimit = imageWidthHalved;
  float rightBorderLimit = screenSize.width - imageWidthHalved;
  if(pos.x < leftBorderLimit){
    pos.x = leftBorderLimit;
    _velocity = CGPointZero;
  }else if(pos.x > rightBorderLimit){
    pos.x = rightBorderLimit;
    _velocity = CGPointZero;
  }
  _sprite.position = pos;
}


-(void)dealloc
{
  [super dealloc];
  [_sprite removeFromParentAndCleanup:YES];
  _sprite = nil;
}

@end