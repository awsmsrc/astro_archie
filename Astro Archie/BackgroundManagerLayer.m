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
    _bgIndex = 1;
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
  }
  return self;
}

-(void)increaseAltitudeWithVelocity:(float)velocity
{
  //change the background position  
  self.BG1.position = ccp(0, self.BG1.position.y - velocity);
  self.BG2.position = ccp(0, self.BG2.position.y - velocity);
    
  //test to see if either background is offscreen and if so loop it to the top
  if(self.BG1.position.y < -BG1Height){
    self.BG1.position = ccp(0, (self.BG2.position.y + BG2Height));
    //NSLog(@"swapped! BG1.y-BG2.y:%f", self.BG1.position.y - self.BG2.position.y);
  }
  else if(self.BG2.position.y < -BG2Height){
    self.BG2.position = ccp(0, (self.BG1.position.y + BG1Height - 1));
    //NSLog(@"swapped! BG2.y-BG1.y:%f", self.BG2.position.y - self.BG1.position.y);
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
        self.BG1.position = ccp(0, (self.BG2.position.y + BG2Height));
        [self addChild:self.BG1];
      }
      break;
    case 2:
      if (!BG2onscreen) {
        [self removeChild:self.BG2  cleanup:YES];
        self.BG2 = [CCSprite spriteWithFile:filename];
        BG2Height = self.BG2.texture.contentSize.height;
        self.BG2.anchorPoint = ccp(0,0);
        self.BG2.position = ccp(0, (self.BG1.position.y + BG1Height));
        [self addChild:self.BG2];
      }
      break;
    default:
      NSLog(@"Nothing Swapped!!");
      break;
  }
}
@end
