//
//  GameOver.m
//  Astro Archie
//
//  Created by Luke Roberts on 24/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "SimpleAudioEngine.h"
#import "GameScene.h"


@implementation GameOverScene

+(id)scene
{
  CCScene *scene =  [CCScene node];
  CCLayer *layer = [MenuScene node];
  [scene addChild:layer];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png"];
    bg.anchorPoint = ccp(0,0);
    bg.position = ccp(0,0);
    [self addChild:bg z:-1];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Arial" fontSize:30];
    titleLabel.position = ccp(screenSize.width/2, screenSize.height - 50);
    [self addChild:titleLabel];
    
        
    CCMenuItem *playButton = [CCMenuItemImage itemFromNormalImage:@"play_off.png" selectedImage:@"play_on.png"
                                                           target:self
                                                         selector:@selector(startGame)];
    CCMenu *menu = [CCMenu menuWithItems:playButton, nil];
    [self addChild:menu];
    [[SimpleAudioEngine  sharedEngine] playBackgroundMusic:@"evil_music.mp3" loop:YES];
  }
  return self;
}

-(id)initWithScore:(int)score andHeight:(float)height
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  id node = [self.class node];
  CCLabelTTF *scoreText;
  CCLabelTTF *scoreValue;
  CCLabelTTF *heightText;
  CCLabelTTF *heightValue;
  
  //test for highscore
  if(score > [[defaults valueForKey:@"HighScore"] intValue]){
    [defaults setObject:[NSNumber numberWithInt:score] forKey:@"HighScore"];
    scoreText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"NEW HIGH SCORE!"]
                                                fontName:@"Arial"
                                                fontSize:22];
  }
  else{
    scoreText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"YOUR SCORE"]
                                    fontName:@"Arial"
                                    fontSize:22];
  }
  //test for new highest distance
  if(height > [[defaults valueForKey:@"HighestDistance"] floatValue]){
    [defaults setObject:[NSNumber numberWithFloat:height] forKey:@"HighestDistance"];
    heightText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"HIGHEST EVER!"]
                                    fontName:@"Arial"
                                    fontSize:22];
  }
  else{
    heightText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"DISTANCE"]
                                    fontName:@"Arial"
                                    fontSize:22];
  }
  
  scoreValue = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", score]
                                   fontName:@"Arial"
                                   fontSize:42];
  heightValue = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.2fKm", height/1000]
                                    fontName:@"Arial"
                                    fontSize:42];
  
  scoreText.position = ccp(screenSize.width/2, 150);
  scoreValue.position = ccp(screenSize.width/2, 120);
  
  heightText.position = ccp(screenSize.width/2, 80);
  heightValue.position = ccp(screenSize.width/2, 50);
  
  [node addChild:scoreText];
  [node addChild:scoreValue];
  [node addChild:heightText];
  [node addChild:heightValue];
  return node;
}



-(void)startGame
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
  [[SimpleAudioEngine  sharedEngine] stopBackgroundMusic];
  GameScene * gs = [GameScene node];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: gs]];
}

@end

