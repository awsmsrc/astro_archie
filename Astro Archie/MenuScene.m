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
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
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
    CCSprite *bg = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aStartMenuBackground]];
    bg.anchorPoint = ccp(0,0);
    bg.position = ccp(0,0);
    [self addChild:bg z:-1];
    CCMenuItem *playButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:play]
                                                    selectedImage:[[assetManager class] getButtonFilepathFor:playPushed]
                                                           target:self
                                                         selector:@selector(startGame)];
    playButton.scaleX = 0.75;
    float posX = playButton.contentSize.width/2 -20;
    playButton.position = ccp(posX, screenSize.height - screenSize.height/3 );
    
    
    float spacing = 1.25 * playButton.contentSize.height;
    
    CCMenuItem *settingsButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:settings]
                                                        selectedImage:[[assetManager class] getButtonFilepathFor:settingsPushed]
                                                           target:self
                                                         selector:@selector(settingsScreen)];    
    settingsButton.scaleX = 0.75;
    settingsButton.position = ccp(posX, playButton.position.y - spacing );
    
    CCMenuItem *guideButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:help]
                                                        selectedImage:[[assetManager class] getButtonFilepathFor:helpPushed]
                                                               target:self
                                                             selector:@selector(helpScreen)];
    guideButton.scaleX = 0.75;
    guideButton.position = ccp(posX, settingsButton.position.y - spacing );
    
    
    CCMenu *menu = [CCMenu menuWithItems:playButton, settingsButton, guideButton, nil];
    menu.position = CGPointZero;
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

-(void)helpScreen{
  if(self.menuEnabled){
    [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
    [helpLayer helpLayerWithParentNode:self];
    self.isTouchEnabled = NO;
    self.menuEnabled = NO;
  }
}

-(void)enableMenu{
  self.menuEnabled = YES;
}

@end
