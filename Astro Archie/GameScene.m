//
//  GameScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene 

+(id)scene
{
  CCScene *scene =  [CCScene node];
  CCLayer *layer =  [GameScene node];
  [scene addChild:layer];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    self.isTouchEnabled = YES;
    self.isAccelerometerEnabled = YES;
    screenSize = [[CCDirector sharedDirector] winSize];
    [self setUpSprites];
    [self scheduleUpdate];
  }
  return self;
}

-(void)setUpSprites
{
  CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
  bg.position = ccp(screenSize.width/2, screenSize.height/2);
  [self addChild:bg];
  player = [CCSprite spriteWithFile:@"archie.png"];
  [self addChild:player z:0 tag:1];
  float imageHeight = [player texture].contentSize.height;
  player.position = CGPointMake(screenSize.width/2, imageHeight/2);
}

-(void)update:(ccTime)delta
{
  CGPoint pos = player.position;
  pos.x += playerVelocity.x;
  //limit the player from leaving the screen
  float imageWidthHalved = [player texture].contentSize.width *0.5f;
  float leftBorderLimit = imageWidthHalved;
  float rightBorderLimit = screenSize.width - imageWidthHalved;
  if(pos.x < leftBorderLimit){
    pos.x = leftBorderLimit;
    playerVelocity = CGPointZero;
  }else if(pos.x > rightBorderLimit){
    pos.x = rightBorderLimit;
    playerVelocity = CGPointZero;
  }
  player.position = pos;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  float deceleration = 0.2f;
  float sensitivity = 8.0f;
  float maxVelocity = 80;
  playerVelocity.x = playerVelocity.x * deceleration + acceleration.x * sensitivity;
  if(playerVelocity.x > maxVelocity){
    playerVelocity.x > maxVelocity;
  }else if(playerVelocity.x < - maxVelocity){
    playerVelocity.x = -maxVelocity;
  }
}

-(void)dealloc
{
  [super dealloc];
}

@end
