//
//  EnemyMeteor.m
//  Astro Archie
//
//  Created by Ben Waxman on 27/03/2013.
//
//

#import "EnemyMeteor.h"

@implementation EnemyMeteor

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aMeteor]]];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float posX = arc4random_uniform(0.7 * screenSize.width) + (0.15 * screenSize.width);
    [self sprite].position = ccp(posX, screenSize.height+50);
    flameEmitter = [self flameEffect];
    flameEmitter.position = ccp((self.sprite.texture.contentSize.width / 2), 10);
    [[self sprite] addChild:flameEmitter z:-1];
    [self addChild:self.sprite];
    [parentNode  addChild:self];

  }
  return self;
}

-(void)moveEnemy:(float)playerVelocity
{
  self.sprite.position = ccp(self.sprite.position.x, self.sprite.position.y - playerVelocity * 1.25);
}

-(CCParticleSystem *)flameEffect{
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
  particle.startSize=20.37;
  particle.startSizeVar=10.00;
  particle.endSize=50.33;
  particle.endSizeVar=5.00;
  particle.gravity=ccp(0.00,50.00);
  particle.radialAccel=0.00;
  particle.radialAccelVar=0.00;
  particle.speed=25;
  particle.speedVar= 5;
  particle.tangentialAccel= 0;
  particle.tangentialAccelVar= 0;
  particle.totalParticles=224;
  particle.life=0.30;
  particle.lifeVar=0.20;
  particle.startSpin=0.00;
  particle.startSpinVar=0.00;
  particle.endSpin=0.00;
  particle.endSpinVar=0.00;
  particle.position=ccp(240.00,160.00);
  particle.posVar=ccp(0.00,0.00);
  return particle;
}

@end
