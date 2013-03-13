//
//  BackgroundManagerLayer.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundManagerLayer.h"


@implementation BackgroundManagerLayer

@synthesize BG1 = _BG1;
@synthesize BG2 = _BG2;

-(id)initWithParentNode:(id)parentNode
{
  if(self = [super init]){
    _bgIndex = 0;
    self.BG1 = [CCSprite spriteWithFile:@"bg1.png"];
    BG1Height = self.BG1.texture.contentSize.height;
    self.BG1.anchorPoint = ccp(0,0);
    self.BG1.position = ccp(0,0);
    self.BG2 = [CCSprite spriteWithFile:@"bg2.png"];
    BG2Height = self.BG2.texture.contentSize.height;
    self.BG2.anchorPoint = ccp(0,0);
    self.BG2.position = ccp(0, BG1Height -1 );
    [self addChild:self.BG1];
    [self addChild:self.BG2];
    [parentNode addChild:self z:-1];
    [self addStars];
  }
  return self;
}

-(void)increaseAltitudeWithVelocity:(float)velocity
{
  //change the background position  
  if(_bgIndex < 3)
   self.BG1.position = ccp(0, self.BG1.position.y - velocity);
  if(_bgIndex < 2)
    self.BG2.position = ccp(0, self.BG2.position.y - velocity);
    
  //test to see if either background is offscreen and if so loop it to the top
  if(self.BG1.position.y < -BG1Height){
    self.BG1.position = ccp(0, (self.BG2.position.y + BG2Height));
    _bgIndex++;
    //NSLog(@"swapped! BG1.y-BG2.y:%f", self.BG1.position.y - self.BG2.position.y);
  }
  else if(self.BG2.position.y < -BG2Height){
    self.BG2.position = ccp(0, (self.BG1.position.y + BG1Height - 1));
    //NSLog(@"swapped! BG2.y-BG1.y:%f", self.BG2.position.y - self.BG1.position.y);
    _bgIndex++;
  }
switch(_bgIndex){
  case 1:
    [self swapBackgroundSprite:1 with:@"bg3.png"];
    break;
  default:
    break;
}
}

-(void)swapBackgroundSprite:(int)BGNo with:(NSString *)filename
{
  float screenHeight = [[CCDirector sharedDirector] winSize].height;
  bool BG1onscreen = false, BG2onscreen = false;
  
  //set a flag if the background is onscreen
  if(self.BG1.position.y < screenHeight)
    BG1onscreen = true;
  if(self.BG2.position.y < screenHeight)
    BG2onscreen = true;
  
  //swap background(BGNo) if not onscreen
  switch (BGNo) {
    case 1:
      if (!BG1onscreen) {
        [self removeChild:self.BG1  cleanup:YES];
        self.BG1 = [CCSprite spriteWithFile:filename];
        BG1Height = self.BG1.texture.contentSize.height;
        self.BG1.anchorPoint = ccp(0,0);
        self.BG1.position = ccp(0, (self.BG2.position.y + BG2Height -2));
        [self addChild:self.BG1 z:-1];
      }
      break;
    case 2:
      if (!BG2onscreen) {
        [self removeChild:self.BG2  cleanup:YES];
        self.BG2 = [CCSprite spriteWithFile:filename];
        BG2Height = self.BG2.texture.contentSize.height;
        self.BG2.anchorPoint = ccp(0,0);
        self.BG2.position = ccp(0, (self.BG1.position.y + BG1Height -2));
        [self addChild:self.BG2 z:-1];
      }
      break;
    default:
      NSLog(@"Nothing Swapped!!");
      break;
  }
}

-(void)addStars{
  CCParticleSystem *particle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:150] autorelease];
  ///////**** Assignment Texture Filename!  ****///////
  CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"bg_star_particle.png"];
  particle.texture=texture;
  particle.emissionRate=20.00;
  particle.angle=-90.0;
  particle.angleVar=5.0;
  ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
  particle.blendFunc=blendFunc;
  particle.duration=-1.00;
  particle.emitterMode=kCCParticleModeGravity;
  ccColor4F startColor={0.70,0.80,1.00,1.00};
  particle.startColor=startColor;
  ccColor4F startColorVar={0.14,0.14,0.14,0.50};
  particle.startColorVar=startColorVar;
  ccColor4F endColor={0.70,0.80,1.00,0.00};
  particle.endColor=endColor;
  ccColor4F endColorVar={0.42,0.47,0.47,0.43};
  particle.endColorVar=endColorVar;
  particle.startSize=10.00;
  particle.startSizeVar=1.00;
  particle.endSize=-1.00;
  particle.endSizeVar=0.00;
  particle.gravity=ccp(0.00,-3.00);
  particle.radialAccel=0.00;
  particle.radialAccelVar=0.00;
  particle.speed= 0;
  particle.speedVar= 0;
  particle.tangentialAccel= 0;
  particle.tangentialAccelVar= 0;
  particle.totalParticles=150;
  particle.life=5.00;
  particle.lifeVar=4.00;
  particle.startSpin=0.00;
  particle.startSpinVar=0.00;
  particle.endSpin=0.00;
  particle.endSpinVar=0.00;
  particle.position=ccp(252.00,141.00);
  particle.posVar=ccp(358.40,415.40);
  
  /////*** Assignment PARENT NODE!!!  ***/////
  [self addChild:particle];
}
@end
