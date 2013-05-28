//
//  GameOver.m
//  Astro Archie
//
//  Created by Luke Roberts on 24/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "GameOverScene.h"
#import "SimpleAudioEngine.h"
#import "GameScene.h"
#import <Twitter/Twitter.h>

@implementation GameOverScene
@synthesize score = _score;

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
    CCSprite *bg = [CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aEndMenuBackground]];
    bg.anchorPoint = ccp(0,0);
    bg.position = ccp(0,0);
    [self addChild:bg z:-1];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItem *playButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:play]
                                                    selectedImage:[[assetManager class] getButtonFilepathFor:playPushed]
                                                           target:self
                                                         selector:@selector(startGame)];
    
    CCMenuItem *tweetButton = [CCMenuItemImage itemFromNormalImage:[[assetManager class] getButtonFilepathFor:tweet]
                                                    selectedImage:[[assetManager class] getButtonFilepathFor:tweetPushed]
                                                           target:self
                                                         selector:@selector(tweetScore)];
    playButton.scaleX = 0.75;
    playButton.position = ccp(playButton.contentSize.width/2 -20, screenSize.height/2 );
    tweetButton.position = ccp(playButton.contentSize.width/2 -20, (screenSize.height/2 - 80));
    tweetButton.scaleX = 0.75;
    
    CCMenu *menu = [CCMenu menuWithItems:playButton, tweetButton, nil];
    menu.position = CGPointZero;
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
  
  ccColor3B normalColour;
  ccColor3B highlightColour = ccc3(255,0,0);
  
  if([[defaults valueForKey:@"HighVisibilty"] boolValue]){
    normalColour = ccc3(255,255,255);
  }
  else
    normalColour = ccc3(0,0,0);
  
  //test for highscore
  if(score > [[defaults valueForKey:@"HighScore"] intValue]){
    [defaults setObject:[NSNumber numberWithInt:score] forKey:@"HighScore"];
    scoreText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"NEW HIGH SCORE!"]
                                                fontName:@"Arial"
                                                fontSize:22];
    scoreText.color = highlightColour;
  }
  else{
    scoreText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"YOUR SCORE"]
                                    fontName:@"Arial"
                                    fontSize:22];
    scoreText.color = normalColour;
  }
  //test for new highest distance
  if(height > [[defaults valueForKey:@"HighestDistance"] floatValue]){
    [defaults setObject:[NSNumber numberWithFloat:height] forKey:@"HighestDistance"];
    heightText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"HIGHEST EVER!"]
                                    fontName:@"Arial"
                                    fontSize:22];
    heightText.color = highlightColour;
  }
  else{
    heightText = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"DISTANCE"]
                                    fontName:@"Arial"
                                    fontSize:22];
    heightText.color = normalColour;
  }
  
  scoreValue = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", score]
                                   fontName:@"Arial"
                                   fontSize:42];
  scoreValue.color = normalColour;
  heightValue = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.2fKm", height/1000]
                                    fontName:@"Arial"
                                    fontSize:42];
  heightValue.color = normalColour;
  
  float posX = 110;
  //scoreText.anchorPoint = scoreValue.anchorPoint = heightText.anchorPoint = heightValue.anchorPoint = CGPointZero;
  scoreText.position  = ccp(posX, screenSize.height - 80);
  scoreValue.position = ccp(posX, scoreText.position.y - 30);
  
  heightText.position  = ccp(posX, scoreValue.position.y - 40);
  heightValue.position = ccp(posX, heightText.position.y - 30);
  
  [node addChild:scoreText];
  [node addChild:scoreValue];
  [node addChild:heightText];
  [node addChild:heightValue];
  
  [node setScore:[[NSNumber alloc] initWithInt:score]];
  NSLog(@"initialize score");
  NSLog(@"%@", self.score);
  return node;
}



-(void)startGame
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
  [[SimpleAudioEngine  sharedEngine] stopBackgroundMusic];
  GameScene * gs = [GameScene node];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: gs]];
}

-(NSString *)tweetText
{
  return [NSString stringWithFormat:@"I just scored %@ in Astro Archie, download it and see if you can beat me!", [self score]];
}

-(void)tweetScore
{
  AppDelegate *app = (((AppDelegate *)[UIApplication sharedApplication].delegate));
  if ([TWTweetComposeViewController canSendTweet])
  {
    TWTweetComposeViewController *tweetSheet =[[TWTweetComposeViewController alloc] init];
    [tweetSheet setInitialText: [self tweetText]];
    [app.viewController presentModalViewController:tweetSheet animated:YES];
  }
  else
  {
     UIAlertView *alertView = [[UIAlertView alloc]
                                initWithTitle:@"Sorry"
                                message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
     [alertView show];
  }

}

@end

