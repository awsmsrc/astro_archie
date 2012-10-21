//
//  GameScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"
#import "MenuScene.h"
#import "CoinManager.h"



@implementation GameScene 

+(id)scene
{
  CCScene *scene =  [CCScene node];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    _pauseScreenUp = NO;
    screenSize = [[CCDirector sharedDirector] winSize];
    gameLayer =  [CCLayer node];
    hudLayer = [CCLayer node];
    [self addChild:gameLayer z:0];
    [self addChild:hudLayer z:999];
    [self setUpScene];
    [player takeOff];
  }
  return self;
}


-(void)beginGameplay{
  [[SimpleAudioEngine  sharedEngine] playBackgroundMusic:@"luke loop 3.mp3" loop:YES];
  self.isTouchEnabled = YES;
  self.isAccelerometerEnabled = YES;
  [self startScoreTimer];
  [self scheduleUpdate];
}

-(void)startScoreTimer
{
  [self schedule:@selector(incrementScore) interval:0.05];
}

-(void)incrementScore
{
  score++;
  [scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
}

-(void)setUpScene
{
  [self addBackgroundSprite];
  [self addPlayer];
  [self addHUD];
}

-(void)addBackgroundSprite
{
  bg = [CCSprite spriteWithFile:@"bg_1_1.png"];
  bg.anchorPoint = ccp(0,0);
  bg.position = bg.anchorPoint;
  [gameLayer addChild:bg z:-1];
  CoinManager *coin = [[CoinManager alloc] initWithParentNode:bg];
}

-(void)addPlayer
{
  player = [[Player alloc] initWithParentNode:gameLayer];
}

-(void)addHUD
{
  CCSprite *hud = [CCSprite spriteWithFile:@"HUD.png"];
  hud.anchorPoint = ccp(0, 0);
  hud.position = ccp(0, screenSize.height - [hud texture].contentSize.height);
  [hudLayer addChild:hud z:0];
  
  CCMenuItem *pauseButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pushed.png"
                                                         target:self
                                                       selector:@selector(pauseGame)];
  
  CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
  menu.position = ccp(22, screenSize.height - 25);
  [hudLayer addChild:menu z:1];
  
  CCSprite *boost = [CCSprite spriteWithFile:@"rocket.png"];
  boost.position = ccp(screenSize.width - 30, 30);
  [hudLayer addChild:boost];

  scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:18];
  float leftOffset = screenSize.width - screenSize.width / 25;
  float topOffset = screenSize.height - screenSize.height/ 30;
  scoreLabel.position = ccp(leftOffset, topOffset);
  scoreLabel.anchorPoint = CGPointMake(1.0f, 1.0f);
  [hudLayer addChild:scoreLabel z:999];
}

-(void)pauseGame
{
  if(_pauseScreenUp == NO)
  {
    _pauseScreenUp= YES;
    //if you have music uncomment the line bellow
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [[CCDirector sharedDirector] pause];
    pauseLayer = [CCLayerColor layerWithColor: ccc4(80, 80, 80, 160) width: screenSize.width height: screenSize.height];
    pauseLayer.position = CGPointZero;
    [hudLayer addChild: pauseLayer];
    
    
    CCMenuItem *ResumeMenuItem = [CCMenuItemImage
                                itemFromNormalImage:@"resume.png" selectedImage:@"resume_pushed.png"
                              target:self selector:@selector(ResumeButtonTapped:)];
    ResumeMenuItem.position = ccp(0, 30);
    
    CCMenuItem *QuitMenuItem = [CCMenuItemImage
                               itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                               target:self selector:@selector(QuitButtonTapped:)];
    QuitMenuItem.position = ccp(0, -30);
    
    _pauseScreenMenu = [CCMenu menuWithItems:ResumeMenuItem,QuitMenuItem, nil];
    [hudLayer addChild:_pauseScreenMenu z:99999];
  }
}

-(void)ResumeButtonTapped:(id)sender{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
  [hudLayer removeChild:_pauseScreenMenu cleanup:YES];
  [hudLayer removeChild:pauseLayer cleanup:YES];
  [[CCDirector sharedDirector] resume];
  _pauseScreenUp=FALSE;
}

-(void)QuitButtonTapped:(id)sender{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
  [hudLayer removeChild:_pauseScreenMenu cleanup:YES];
  [hudLayer removeChild:pauseLayer cleanup:YES];
  [[CCDirector sharedDirector] resume];
  _pauseScreenUp=FALSE;
  MenuScene * ms = [MenuScene node];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: ms]];
}

-(void)update:(ccTime)delta
{
  [self increaseAltitude];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  [player applyAcceleration:acceleration];
}

-(void)increaseAltitude
{
  bg.position = ccp(bg.position.x, bg.position.y - 2);
}

-(void)dealloc
{
  [super dealloc];
}

@end
