//
//  BackgroundManagerLayer.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundManagerLayer.h"


@implementation BackgroundManagerLayer

@synthesize currentBG = _currentBG;
@synthesize nextBG = _nextBG;

-(id)initWithParentNode:(id)parentNode
{
  if(self = [super init]){
    _bgIndex = 1;
    self.currentBG = [CCSprite spriteWithFile:@"bg1.png"];
    self.currentBG.anchorPoint = ccp(0,0);
    self.currentBG.position = ccp(0,0);
    self.nextBG = [CCSprite spriteWithFile:@"bg2.png"];
    self.nextBG.position = ccp(0, [[self.currentBG texture] contentSize].height);
    [self addChild:self.currentBG];
    [self addChild:self.nextBG];
    [parentNode addChild:self z:-1];
  }
  return self;
}

-(void)increaseAltitudeWithVelocity:(float)velocity
{
  float screenHeight = [[CCDirector sharedDirector] winSize].height;
  //change the background position
  self.currentBG.position = ccp(0, self.currentBG.position.y - velocity);
  self.nextBG.position = ccp(0, self.nextBG.position.y - velocity);
  
  //get height and position info for comparison
  float currentHeight = [[self.currentBG texture] contentSize].height;
  float nextHeight = [[self.nextBG texture] contentSize].height;
  float posY = self.currentBG.position.y;
  
  //test to see if current background is offscreen
  if(posY < -currentHeight){
    posY = self.nextBG.position.y + nextHeight;
    self.currentBG.position = ccp(0, posY);
    //swap current and next backgrounds
    //CCSprite *temp = _currentBG;
    //_currentBG = _nextBG;
    //_nextBG = temp;
    self.currentBG = self.nextBG;
    self.currentBG.position = ccp(0,0);
//    self.nextBG = someMethod that sets the next bg;
    
  }
  NSLog(@"%f", currentHeight);
  NSLog(@"%f", posY);
}
@end
