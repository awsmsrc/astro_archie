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
  CCLayer *layer = [GameScene node];
  [scene addChild:layer];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    self.isAccelerometerEnabled = YES;
    CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
    bg.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:bg];
    player = [CCSprite spriteWithFile:@"archie.png"];
    [self addChild:player z:0 tag:1];
    float imageHeight = [player texture].contentSize.height;
    player.position = CGPointMake(screenSize.width/2, imageHeight/2);
  }
  return self;
}

-(void)dealloc
{
  [super dealloc];
}


@end
