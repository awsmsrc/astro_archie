//
//  GameScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"



@implementation GameScene
@synthesize coinManager = _coinManager;

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
  [self scheduleUpdate];
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
  [self setCoinManager:[[CoinManager alloc] initWithParentNode:gameLayer]];
}

-(void)addPlayer
{
  player = [[Player alloc] initWithParentNode:gameLayer];
}

-(void)addHUD
{
  //TODO create a custom HUDLayer class
  //HUD bg
  CCSprite *hud = [CCSprite spriteWithFile:@"HUD.png"];
  hud.anchorPoint = ccp(0, 0);
  hud.position = ccp(0, screenSize.height - [hud texture].contentSize.height);
  [hudLayer addChild:hud z:0];
  
  
  //pause menu
  CCMenuItem *pauseButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause_pushed.png"
                                                         target:self
                                                       selector:@selector(pauseGame)];
  CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
  menu.position = ccp(22, screenSize.height - 25);
  [hudLayer addChild:menu z:1];
  
  CCSprite *boost = [CCSprite spriteWithFile:@"rocket.png"];
  boost.position = ccp(screenSize.width - 30, 30);
  [hudLayer addChild:boost];

  
  //score label
  scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:18];
  float leftOffset = screenSize.width - screenSize.width / 25;
  float topOffset = screenSize.height - screenSize.height/ 30;
  scoreLabel.position = ccp(leftOffset, topOffset);
  scoreLabel.anchorPoint = CGPointMake(1.0f, 1.0f);
  [hudLayer addChild:scoreLabel z:999];
  
  //fuel guage
  //initialize progress bar
  fuel = [CCProgressTimer progressWithFile:@"fuel.png"];
  
  //set the progress bar type to horizontal from left to right
  fuel.type = kCCProgressTimerTypeHorizontalBarLR;
  
  //initialize the progress bar to zero
  fuel.percentage = 100;
  
  //add the CCProgressTimer to our layer and set its position
  [hudLayer addChild:fuel z:1 tag:20];
  [fuel setAnchorPoint:ccp(0,0)];
  [fuel setPosition:ccp(60, screenSize.height - 40)];

}

-(void)pauseGame
{
  if(_pauseScreenUp == NO){
    [self buttonPushed];
    _pauseScreenUp= YES;
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
  [self buttonPushed];
  [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
  [hudLayer removeChild:_pauseScreenMenu cleanup:YES];
  [hudLayer removeChild:pauseLayer cleanup:YES];
  [[CCDirector sharedDirector] resume];
  _pauseScreenUp=FALSE;
}

-(void)QuitButtonTapped:(id)sender{
  [self buttonPushed];
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
  [[self coinManager] handleCollisionsWith:player];
  [scoreLabel setString:[NSString stringWithFormat:@"%i", [player score]]];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  [player applyAcceleration:acceleration];
}

-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}

-(void)increaseAltitude
{
  bg.position = ccp(bg.position.x, bg.position.y - 2);
  fuel.percentage = fuel.percentage - 0.05f;
  [[self coinManager] animateCoins:2];
}

-(void)dealloc
{
  [self removeChild:player cleanup:YES];
  player = nil;
  [super dealloc];
}

@end
