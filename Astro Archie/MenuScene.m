//
//  MenuScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#include "SimpleAudioEngine.h"
#import "GameScene.h"


@implementation MenuScene

@synthesize menuEnabled = _menuEnabled;
+(id)scene
{
  CCScene *scene =  [CCScene node];
  CCLayer *layer = [MenuScene node];
  [scene addChild:layer];
  return scene;
}

-(id)init
{
  self.menuEnabled = YES;
  //register user default settings
  NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Tilt", @"Control",
                                  [NSNumber numberWithFloat:1.0f], @"SpeedOveride",
                                  [NSNumber numberWithBool:NO], @"HighVisibilty",
                                  [NSNumber numberWithInt:0], @"HighScore",
                                  [NSNumber numberWithFloat:0.0f], @"HighestDistance",
                                  nil];
  [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
  
  if((self = [super init])){
    CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png"];
    bg.anchorPoint = ccp(0,0);
    bg.position = ccp(0,0);
    [self addChild:bg z:-1];
    CCMenuItem *playButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:play]
                                                    selectedImage:[[assetManager class] getButtonFilepathFor:playPushed]
                                                           target:self
                                                         selector:@selector(startGame)];
    CCMenuItem *settingsButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:settings]
                                                        selectedImage:[[assetManager class] getButtonFilepathFor:settingsPushed]
                                                           target:self
                                                         selector:@selector(settingsScreen)];
    settingsButton.position = ccp(0, -60);
    CCMenu *menu = [CCMenu menuWithItems:playButton, settingsButton, nil];
    [self addChild:menu];
    [[SimpleAudioEngine  sharedEngine] playBackgroundMusic:@"luke loop 1.mp3" loop:YES];
  }
  return self;
}

-(void)startGame
{
  if(self.menuEnabled){
    [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
    [[SimpleAudioEngine  sharedEngine] stopBackgroundMusic];
    GameScene * gs = [GameScene node];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: gs]];
  }
}

-(void)settingsScreen{
  if(self.menuEnabled){
    [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
    [SettingsLayer settingsLayerWithParentNode:self];
    self.isTouchEnabled = NO;
    self.menuEnabled = NO;
  }  
}

-(void)enableMenu{
  self.menuEnabled = YES;
}

@end
