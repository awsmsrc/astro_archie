//
//  HUDLayer.m
//  Astro Archie
//
//  Created by Luke Roberts on 14/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"



@implementation HUDLayer

-(id)initWithParentNode:(id)parentNode
{
  if(self = [super init]){
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    //HUD bg
    CCSprite *hud = [CCSprite spriteWithFile:@"HUD.png"];
    hud.anchorPoint = ccp(0, 0);
    hud.position = ccp(0, screenSize.height - [hud texture].contentSize.height);
    [self addChild:hud z:0];
  
  
    //pause menu
    CCMenuItem *pauseButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pushed.png"
                                                          target:parentNode
                                                        selector:@selector(pauseGame)];
    CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
    menu.position = ccp(22, screenSize.height - 25);
    [self addChild:menu z:1];
  
//    CCSprite *boost = [CCSprite spriteWithFile:@"rocket.png"];
//    boost.position = ccp(screenSize.width - 30, 30);
//    [self addChild:boost];
  
  
    //score label
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:18];
    float leftOffset = screenSize.width - screenSize.width / 25;
    float topOffset = screenSize.height - screenSize.height/ 30;
    scoreLabel.position = ccp(leftOffset, topOffset);
    scoreLabel.anchorPoint = CGPointMake(1.0f, 1.0f);
    [self addChild:scoreLabel z:999];
  
    //fuel guage
    //initialize progress bar
    fuelGuage = [CCProgressTimer progressWithFile:@"fuel_guage.png"];
  
    //set the progress bar type to horizontal from left to right
    fuelGuage.type = kCCProgressTimerTypeHorizontalBarLR;
  
    //initialize the progress bar to zero
    fuelGuage.percentage = 100;
  
    //add the CCProgressTimer to our layer and set its position
    [self addChild:fuelGuage z:1 tag:20];
    [fuelGuage setAnchorPoint:ccp(0,0)];
    [fuelGuage setPosition:ccp(60, screenSize.height - 40)];
  }
  return self;
}

-(void)updateWithPlayer:(Player *)player;
{
  [scoreLabel setString:[NSString stringWithFormat:@"%i", [player score]]];
  fuelGuage.percentage = [player fuel];
}

@end
