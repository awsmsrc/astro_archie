//
//  Player.m
//  Astro Archie
//
//  Not Created by Luke Roberts on 18/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize sprite = _sprite;

-(id)initWithParentNode:(CCNode *)parentNode
{
  if(self = [super init]){
    _fuel = 100;
    _velocity.y = 3;
    [self initSpriteWithParentNode:parentNode];
  }
  return self;
}

-(void)takeOff
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  CCSequence *seq = [CCSequence actions:
                    [CCDelayTime actionWithDuration:1.2],
                    [CCCallFunc actionWithTarget:self selector:@selector(initJetPack)],
                    [CCCallFunc actionWithTarget:self selector:@selector(takeOffDidBegin)],
                    [CCMoveTo actionWithDuration:0.35 position:ccp(_sprite.position.x, _sprite.position.y + screenSize.height/6)],
                    [CCCallFunc actionWithTarget:self.parent.parent selector:@selector(beginGameplay)],
                    [CCCallFunc actionWithTarget:self selector:@selector(scheduleUpdate)],
                    nil];
  [_sprite runAction:seq];
}

-(void)initSpriteWithParentNode:(id)parentNode
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  [self setSprite:[CCSprite spriteWithFile:@"archie.png"]];
  float imageHeight = [_sprite texture].contentSize.height;
  [self sprite].position = CGPointMake(screenSize.width/2, imageHeight/2);
  [parentNode addChild:self];
  [self addChild:[self sprite] z:0 tag:1];
}

-(void)initJetPack
{
  flameEmitterLeft = [CCParticleFire node];
  flameEmitterLeft.texture = [[CCTextureCache sharedTextureCache] addImage:@"flame.png"];
  flameEmitterLeft.scale = 0.15;
  flameEmitterLeft.angle = 270;
  flameEmitterLeft.totalParticles = 20;
  flameEmitterLeft.life = 1;
  flameEmitterLeft.speed = 400;
  flameEmitterLeft.position = ccp(([self sprite].texture.contentSize.width / 2) - 18, 10);
  [[self sprite] addChild:flameEmitterLeft z:-1];
  flameEmitterRight = [CCParticleFire node];
  flameEmitterRight.texture = [[CCTextureCache sharedTextureCache] addImage:@"flame.png"];
  flameEmitterRight.scale = 0.15;
  flameEmitterRight.angle = 270;
  flameEmitterRight.totalParticles = 20;
  flameEmitterRight.life = 1;
  flameEmitterRight.speed = 400;
  flameEmitterRight.position = ccp(([self sprite].texture.contentSize.width / 2) + 18, 10);
  [[self sprite] addChild:flameEmitterRight z:-1];
}

-(void)didCollideWithObject:(id)object
{
  if([object isKindOfClass:[Coin class]]){
    [self didCollectCoin];
  }
  else if([object isKindOfClass:[Fuel class]])
  {
    [self didCollectFuel];
  }
  else if([object isKindOfClass:[Special class]])
  {
    [self didCollectSpecial:object];
  }
}

-(void)collectionEffect
{
  CCParticleSystem *emitter = [CCParticleExplosion node];
  [emitter setEmitterMode:kCCParticleModeRadius];
  emitter.endRadius = 100;
  emitter.duration = 0.05f;
  emitter.life = 0.05f;
  emitter.position = [self sprite].position;
  emitter.scale = 0.3f;
  emitter.totalParticles = 45;
  emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"particle.png"];
  [emitter setAutoRemoveOnFinish:YES];
  [[self parent] addChild: emitter z:-1];
}


-(void)didCollectSpecial:(Special*)object
{
  _score += object._bonusPoints;
  _fuel += object._bonusFuel;
  [self setTargetYVelocity:(_targetYVelocity + object._bonusSpeed)];
}

-(void)didCollectCoin
{
  [self collectionEffect];
  _score = _score +100;
}

-(void)didCollectFuel
{
  if(_fuel >= 80){
    _fuel = 100;
  }else{
    _fuel = _fuel + 20;
  }
}

-(void)incrementScore
{
  _score = _score + 1;
}

-(float)fuel
{
  return _fuel;
}

-(void)decrementFuel
{
  _fuel = _fuel - ([self getYVelocity]/25);
}

-(int)score
{
  return _score;
}

-(void)takeOffDidBegin
{
  [self schedule:@selector(incrementScore) interval:0.05];
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

-(float)getYVelocity
{
  return _velocity.y;
}

-(void)setTargetYVelocity:(float)targetVelocity
{
  const float MAX_SPEED = 10.0f; //<<<<<<<<<<<<<<<<<<<<<<<<<<<< MAXIMUM SPEED
  _targetYVelocity = targetVelocity;
  _targetYVelocity = MIN(_targetYVelocity, MAX_SPEED);
}

-(void)update:(ccTime)delta
{
  [self steerArchie];
  if(_targetYVelocity > [self getYVelocity]){
    _velocity.y = MIN(_velocity.y += 0.2, _targetYVelocity);
  }
  //NSLog(@"velocity = %f", _velocity.y);
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
    _velocity.x = 0;
  }else if(pos.x > rightBorderLimit){
    pos.x = rightBorderLimit;
    _velocity.x = 0;
  }
  _sprite.position = pos;
}

-(CGRect)spriteBox
{
  CGRect rect = CGRectMake(self.sprite.position.x - [self.sprite texture].contentSize.width * self.sprite.anchorPoint.x,
                self.sprite.position.y - [self.sprite texture].contentSize.height * self.sprite.anchorPoint.y,
                [self.sprite texture].contentSize.width, [self.sprite texture].contentSize.height);
  return rect;
}


-(void)dealloc
{
  [super dealloc];
  [self.sprite release];
  [self.sprite removeFromParentAndCleanup:YES];
}

@end
