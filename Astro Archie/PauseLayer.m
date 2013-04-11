//
//  PauseLayer.m
//  Astro Archie
//
//  Created by Luke Roberts on 23/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "MenuScene.h"
#import "SimpleAudioEngine.h"


@implementation PauseLayer

-(id)initWithParentNode:(id)parentNode
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  if(self = [super init]){
    [parentNode addChild:self];
    pauseLayer = [CCLayerColor layerWithColor: ccc4(80, 80, 80, 160) width: screenSize.width height: screenSize.height];
    pauseLayer.position = CGPointZero;
    [self addChild: pauseLayer];
    CCMenuItem *ResumeMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:[[assetManager class] getButtonFilepathFor:play]
                                  selectedImage:[[assetManager class] getButtonFilepathFor:playPushed]
                                  target:self selector:@selector(ResumeButtonTapped:)];
    ResumeMenuItem.position = ccp(0, 30);
    CCMenuItem *QuitMenuItem = [CCMenuItemImage
                                itemFromNormalImage:[[assetManager class] getButtonFilepathFor:exitButton]
                                selectedImage:[[assetManager class] getButtonFilepathFor:exitButtonPushed]
                                target:self selector:@selector(QuitButtonTapped:)];
    QuitMenuItem.position = ccp(0, -30);
    pauseScreenMenu = [CCMenu menuWithItems:ResumeMenuItem,QuitMenuItem, nil];
    [pauseLayer addChild:pauseScreenMenu z:99999];
  }
  return self;
}

+(id)pauseLayerWithParentNode:(id)parentNode
{
  return [[[PauseLayer alloc] initWithParentNode:parentNode] autorelease];
}

-(void)ResumeButtonTapped:(id)sender{
  [[[self parent] parent] gameResumed];
  [self buttonPushed];
  [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
  [[self parent] removeChild:pauseScreenMenu cleanup:YES];
  [[self parent] removeChild:pauseLayer cleanup:YES];
  [self removeFromParentAndCleanup:YES];
  [[CCDirector sharedDirector] resume];
}

-(void)QuitButtonTapped:(id)sender{
  [self buttonPushed];
  [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
  [[self parent] removeChild:pauseScreenMenu cleanup:YES];
  [[self parent] removeChild:pauseLayer cleanup:YES];
  [self removeFromParentAndCleanup:YES];
  [[CCDirector sharedDirector] resume];
  MenuScene * ms = [MenuScene node];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: ms]];
}

-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}


@end
