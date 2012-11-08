//
//  CoinManager.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CollectablesManager.h"
#import "Coin.h"
#import "Fuel.h"
#import "SimpleAudioEngine.h"

@implementation CollectablesManager

@synthesize visibleCoins = _visibleCoins;
@synthesize hiddenCoins = _hiddenCoins;

-(id)initWithParentNode:(id)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    _screenSize = [[CCDirector sharedDirector] winSize];
    _highestCoin = CGPointMake(0,_screenSize.height/2);
    for(int i=0; i < 30; i++){
      Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
      [coin sprite].position = ccp(-50,-50);
      [[self hiddenCoins] addObject:coin];
    }
    for(int i=0; i < 5; i++){
      Fuel *fuel = [[Fuel alloc] initWithParentNode:parentNode];
      [fuel sprite].position = ccp(-50,-50);
      [[self hiddenCoins] addObject:fuel];
    }
    [self drawRandomLine];
  }
  return self;
}

-(NSMutableArray *)visibleCoins
{
  if(!_visibleCoins){
    _visibleCoins  = [[NSMutableArray alloc] init];
  }
  return _visibleCoins;
}

-(NSMutableArray *)hiddenCoins
{
  if(!_hiddenCoins){
    _hiddenCoins  = [[NSMutableArray alloc] init];
  }
  return _hiddenCoins;
}


-(void)animateCoins:(int)distance
{
  for(Coin *coin in [self visibleCoins]){
    coin.sprite.position = ccp(coin.sprite.position.x, coin.sprite.position.y - distance);
    if(coin.sprite.position.y < -10){
      [[self hiddenCoins] addObject:coin];
    }
  }
  [[self visibleCoins] removeObjectsInArray:[self hiddenCoins]];
  _highestCoin.y -= distance;
}

-(void)handleCollisionsWith:(Player *)player
{
  for(Coin *selectedCoin in [self visibleCoins]){
    if(CGRectIntersectsRect([player spriteBox], [selectedCoin spriteBox])){
//      if([selectedCoin isKindOfClass:[Coin class]]){
//        [player didCollectCoin];
//      }
//      else if([selectedCoin isKindOfClass:[Fuel class]]){
//        [player didCollectFuel];
//      }
      [player didCollideWithObject:selectedCoin];
      [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
      selectedCoin.sprite.position = CGPointMake(-50, -50);
      [[self hiddenCoins] addObject:selectedCoin];
    }
  }
  [[self visibleCoins] removeObjectsInArray:[self hiddenCoins]];
}

-(void)populateObjects{
  //NSLog(@"hidden: %i | visible: %i" ,[[self hiddenCoins] count],[[self visibleCoins] count]);
  if([[self hiddenCoins] count] >= 10){
    [self shuffleHidden];
    int randNum = arc4random_uniform(10);
    switch (randNum) {
      case 0:
        //[self drawCircle];
        //break;
      case 1:
        //[self drawTriangle];
        //break;
      case 2:
        //[self drawDiamond];
        //break;
      case 3:
        [self drawSquare];
        break;
      default:
        [self drawRandomLine];
        break;
    }
  }
  
}

-(void)shuffleHidden
{
  int count = [[self hiddenCoins] count];
  for (int i = 0; i < count; ++i) {
    int nElements = count - i;
    int n = (arc4random_uniform(nElements) + i);
    [[self hiddenCoins] exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
}

-(void)drawRandomLine
{
  CGPoint pos;
  for(int i =0; i < 10; i++){
    pos.x = arc4random_uniform(0.8 * _screenSize.width) + (0.1 * _screenSize.width);
    pos.y = (arc4random_uniform(100) + 20) + _highestCoin.y;
    _highestCoin.y = pos.y;
    Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
    selectedCoin.sprite.position = pos;
    [[self visibleCoins] addObject:selectedCoin];
  }
  _highestCoin.x = pos.x;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
}

-(void)drawSquare
{
  CGPoint startPos, pos;
  startPos.x = arc4random_uniform(_screenSize.width/2) + _screenSize.width/4;
  startPos.y = (arc4random_uniform(50) + 20) + _highestCoin.y;
  int i = 0;
  for(int y=0; y < 3; y++){
    pos.y = startPos.y + y * 60;
    for(int x=0; x < 3; x++){
      Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
      pos.x = startPos.x + x * 30;
      selectedCoin.sprite.position = pos;
      [[self visibleCoins] addObject:selectedCoin];
      i++;
    }
  }
  _highestCoin.x = pos.x;
  _highestCoin.y = pos.y + arc4random_uniform(100) + 10;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
}

-(void)drawCircle
{
  //code to draw circle
}

-(void)drawDiamond
{
  //code to draw diamond
}

-(void)drawTriangle
{
  //code to draw triangle
}

-(void)dealloc
{
  [super dealloc];
  [[self visibleCoins] release];
  [[self hiddenCoins] release];
}

@end
