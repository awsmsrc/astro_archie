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
@synthesize height = _height;

-(id)initWithParentNode:(CCNode *)parentNode
{
  if(self = [super init]){
    self.height = 0.0f;
    _fuel = 100;
    _SpeedOveride = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SpeedOveride"] floatValue];
    _velocity.y = _SpeedOveride * 3;
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
  [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aArchie]]];
  float imageHeight = [_sprite texture].contentSize.height;
  [self sprite].position = CGPointMake(screenSize.width/2, imageHeight/2);
  [parentNode addChild:self];
  [self addChild:[self sprite] z:0 tag:1];
}
-(CCParticleSystem *)flameEffect;{
  CCParticleSystem *particle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:224] autorelease];
  ///////**** Assignment Texture Filename!  ****///////
  CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"flame.png"];
  particle.texture=texture;
  particle.emissionRate=212.00;
  particle.angle=0.0;
  particle.angleVar=360.0;
  ccBlendFunc blendFunc={GL_ONE_MINUS_DST_COLOR,GL_ONE_MINUS_SRC_ALPHA};
  particle.blendFunc=blendFunc;
  particle.duration=-1.00;
  particle.emitterMode=kCCParticleModeGravity;
  ccColor4F startColor={0.84,0.74,0.00,0.17};
  particle.startColor=startColor;
  ccColor4F startColorVar={0.00,0.00,0.00,0.00};
  particle.startColorVar=startColorVar;
  ccColor4F endColor={1.00,0.17,0.01,0.28};
  particle.endColor=endColor;
  ccColor4F endColorVar={0.00,0.00,0.00,0.00};
  particle.endColorVar=endColorVar;
  particle.startSize=2.37;
  particle.startSizeVar=10.00;
  particle.endSize=0.33;
  particle.endSizeVar=0.00;
  particle.gravity=ccp(0.00,-500.00);
  particle.radialAccel=0.00;
  particle.radialAccelVar=0.00;
  particle.speed=25;
  particle.speedVar= 5;
  particle.tangentialAccel= 0;
  particle.tangentialAccelVar= 0;
  particle.totalParticles=224;
  particle.life=0.90;
  particle.lifeVar=0.20;
  particle.startSpin=0.00;
  particle.startSpinVar=0.00;
  particle.endSpin=0.00;
  particle.endSpinVar=0.00;
  particle.position=ccp(240.00,160.00);
  particle.posVar=ccp(0.00,0.00);
  return particle;
}
-(void)initJetPack
{
  flameEmitterLeft = [self flameEffect];
  flameEmitterLeft.position = ccp(([self sprite].texture.contentSize.width / 2) - 18, 10);
  flameEmitterRight = [self flameEffect];
  flameEmitterRight.position = ccp(([self sprite].texture.contentSize.width / 2) + 18, 10);
  [[self sprite] addChild:flameEmitterRight z:-1];
  [[self sprite] addChild:flameEmitterLeft z:-1];
}

-(void)didCollideWithObject:(id)object
{
  if([object isKindOfClass:[Coin class]]){
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
    [self didCollectCoin];
  }
  else if([object isKindOfClass:[Fuel class]])
  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
    [self didCollectFuel];
  }
  else if([object isKindOfClass:[Special class]])
  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
    [self didCollectSpecial:object];
  }
  else if([object isKindOfClass:[Enemy class]])
  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Explosion with Metal Debris.wav"];
    _fuel = -1000.0f;
  }

}

-(void)collectionEffect
{
  CCParticleSystem *particle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:250] autorelease];
  CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"collect.png"];
  particle.texture=texture;
  particle.emissionRate=80.00;
  particle.angle=-90.0;
  particle.angleVar=5.0;
  ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
  particle.blendFunc=blendFunc;
  particle.duration=0.58;
  particle.emitterMode=kCCParticleModeGravity;
  ccColor4F startColor={0.70,0.80,1.00,1.00};
  particle.startColor=startColor;
  ccColor4F startColorVar={0.14,0.14,0.14,0.50};
  particle.startColorVar=startColorVar;
  ccColor4F endColor={1.00,0.90,0.00,0.00};
  particle.endColor=endColor;
  ccColor4F endColorVar={0.42,0.47,0.47,0.43};
  particle.endColorVar=endColorVar;
  particle.startSize=2.00;
  particle.startSizeVar=30.00;
  particle.endSize=-1.00;
  particle.endSizeVar=0.00;
  particle.gravity=ccp(0.00,0.00);
  particle.radialAccel=120.94;
  particle.radialAccelVar=360.83;
  particle.speed=109;
  particle.speedVar=103;
  particle.tangentialAccel=-12;
  particle.tangentialAccelVar= 0;
  particle.totalParticles=150;
  particle.life=0.60;
  particle.lifeVar=1.00;
  particle.startSpin=1464.88;
  particle.startSpinVar=0.00;
  particle.endSpin=-1766.62;
  particle.endSpinVar=0.00;
  particle.position=[self sprite].position;
  particle.posVar=ccp(8.00,0.00);
  [particle setAutoRemoveOnFinish:YES];
  [[self parent] addChild: particle z:-1];
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
  _fuel = _fuel - ([self getYVelocity]/30);
}

-(int)score
{
  return _score;
}

-(void)takeOffDidBegin
{
  [self schedule:@selector(incrementScore) interval:0.05/_SpeedOveride];
  [[SimpleAudioEngine sharedEngine] playEffect:@"Explosion with Metal Debris.wav"];
}

-(void)applyAcceleration:(NSNumber *)acceleration
{
  float acc = [acceleration floatValue];
  float deceleration = 0.2f;
  float sensitivity = 8.0f;
  float maxVelocity = 80;
  _velocity.x = _velocity.x * deceleration + acc * sensitivity;
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
  const float MAX_SPEED = _SpeedOveride * 10.0f; //<<<<<<<<<<<<<<<<<<<<<<<<<<<< MAXIMUM SPEED
  _targetYVelocity = _SpeedOveride * targetVelocity;
  _targetYVelocity = MIN(_targetYVelocity, MAX_SPEED);
}

-(void)update:(ccTime)delta
{
  [self steerArchie];
  if(_targetYVelocity > [self getYVelocity]){
    _velocity.y = MIN(_velocity.y += (_SpeedOveride * 0.2), _targetYVelocity);
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
  [[self sprite] setRotation:(_velocity.x*2.2f)];
}

-(CGRect)spriteBox
{
  CGRect rect = CGRectMake(self.sprite.position.x - [self.sprite texture].contentSize.width * self.sprite.anchorPoint.x,
                self.sprite.position.y - [self.sprite texture].contentSize.height * self.sprite.anchorPoint.y,
                [self.sprite texture].contentSize.width, [self.sprite texture].contentSize.height);
  return rect;
}

-(void)increaseHeight
{
  //each background is 4000 pixels high so x 10 to get 40,000 (ie 40km) per background.
  //this conversion with 3 backgrounds gives 120km before space.
  //100km is the Karman Line, the recognised start of space! :)
  _height += _velocity.y * 10.0f;
}



-(void)dealloc
{
  [super dealloc];
  [self.sprite release];
  [self.sprite removeFromParentAndCleanup:YES];
}

@end
