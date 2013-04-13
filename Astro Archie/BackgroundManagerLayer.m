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
@synthesize BGL1 = _BGL1;
@synthesize BGL2 = _BGL2;
@synthesize BGL3 = _BGL3;

-(id)initWithParentNode:(id)parentNode
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  
  if(self = [super init]){
    _bgIndex = 1;
    self.BG1 = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aBGLayer0A]];
    BG1Height = self.BG1.texture.contentSize.height;
    self.BG1.anchorPoint = ccp(0,0);
    self.BG1.position = ccp(0,0);
    
    self.BG2 = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aBGLayer0B]];
    BG2Height = self.BG2.texture.contentSize.height;
    self.BG2.anchorPoint = ccp(0,0);
    self.BG2.position = ccp(0, BG1Height -1 );
    
    self.BGL1 = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aBGLayer1]];
    self.BGL1.anchorPoint = ccp(0,0);
    self.BGL1.position = ccp(0,0);
    self.BGL1.scale = screenSize.width / self.BGL1.texture.contentSize.width;
    
    self.BGL2 = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aBGLayer2]];
    self.BGL2.anchorPoint = ccp(0,0);
    self.BGL2.position = ccp(0,0);
    self.BGL2.scale = screenSize.width / self.BGL2.texture.contentSize.width;
    
    self.BGL3 = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aBGLayer3]];
    self.BGL3.anchorPoint = ccp(0,0);
    self.BGL3.position = ccp(0,0);
    self.BGL3.scale = screenSize.width / self.BGL3.texture.contentSize.width;
    
    [self addChild:self.BG1 z:-5];
    [self addChild:self.BG2 z:-5];
    [self addChild:self.BGL1 z:-3];
    [self addChild:self.BGL2 z:-2];
    [self addChild:self.BGL3 z:-1];
    
    [parentNode addChild:self z:-1];
    [self addStars];
  }
  return self;
}

-(void)increaseAltitudeWithVelocity:(float)velocity
{
  self.BGL1.position = ccp(0, self.BGL1.position.y - velocity * 0.3);
  self.BGL2.position = ccp(0, self.BGL2.position.y - velocity * 0.5);
  self.BGL3.position = ccp(0, self.BGL3.position.y - velocity * 0.9);

  //three backgrounds travelling downwards
  //bg1 swaps to bg3 and moves atop bg2
  //once bg3 has scrolled all the way to black, both backgrounds stop moving
  if(_bgIndex < 4){
    //change the background position  
    self.BG1.position = ccp(0, self.BG1.position.y - velocity);
    self.BG2.position = ccp(0, self.BG2.position.y - velocity);
    
    //test to see if either background is offscreen
    if(self.BG1.position.y < -BG1Height){
      if(_bgIndex == 1){
        [self swapBackgroundSprite:1 with:[[assetManager class] getSpriteFilepathFor:aBGLayer0C]];
        _bgIndex = 2;
      }
      else if(_bgIndex == 3) _bgIndex = 4;
    }
    else if(self.BG2.position.y < -BG2Height){
      if(_bgIndex == 2) _bgIndex = 3;
    }
  }
}

-(void)swapBackgroundSprite:(int)BGNo with:(NSString *)filename
{  
  //swap background(BGNo) if not onscreen
  switch (BGNo) {
    case 1:
      [self removeChild:self.BG1  cleanup:YES];
      self.BG1 = [CCSprite spriteWithFile:filename];
      BG1Height = self.BG1.texture.contentSize.height;
      self.BG1.anchorPoint = ccp(0,0);
      self.BG1.position = ccp(0, (self.BG2.position.y + BG2Height -2));
      [self addChild:self.BG1 z:-5];
      break;
    case 2:
      [self removeChild:self.BG2  cleanup:YES];
      self.BG2 = [CCSprite spriteWithFile:filename];
      BG2Height = self.BG2.texture.contentSize.height;
      self.BG2.anchorPoint = ccp(0,0);
      self.BG2.position = ccp(0, (self.BG1.position.y + BG1Height -2));
      [self addChild:self.BG2 z:-5];
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
  [self addChild:particle z:-4];
}
@end
