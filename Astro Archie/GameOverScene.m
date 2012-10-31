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

-(id)initWithScore:(int)score
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  id node = [self.class node];
  CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"YOUR SCORE: %i", score]
                                              fontName:@"Arial"
                                              fontSize:22];
  scoreLabel.position = ccp(screenSize.width/2, screenSize.height -100);
  [node addChild:scoreLabel];
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

