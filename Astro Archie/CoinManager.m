//
//  CoinManager.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoinManager.h"
#import "Coin.h"
#import "SimpleAudioEngine.h"

@implementation CoinManager

@synthesize visibleCoins = _visibleCoins;
@synthesize hiddenCoins = _hiddenCoins;

-(id)initWithParentNode:(id)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    for(int i=0; i < 100; i++){
      Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
      int x = arc4random()%440 + 20;
      int y = (arc4random()%100 + 50) + (i * 70);
      [coin sprite].position = ccp(x,y);
      [[self visibleCoins] addObject:coin];
    }
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
  }
}

-(void)handleCollisionsWith:(Player *)player
{
  NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
  for(int i=0; i < [[self visibleCoins] count]; i++){
    if(CGRectIntersectsRect([player spriteBox], [[[self visibleCoins] objectAtIndex:i] spriteBox])){
      NSLog(@"collision");
      [player didCollectCoin];
      [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
      [[self hiddenCoins] addObject:[[self visibleCoins] objectAtIndex:i]];
      NSNumber *num = [NSNumber numberWithInt:i];
      [tempArray addObject:num];
    }
  }
  for(int i=0; i < [tempArray count]; i++){
    Coin *coin =[[self visibleCoins] objectAtIndex:(NSNumber *)[[tempArray objectAtIndex:i] intValue]];
    [coin removeFromParentAndCleanup:NO];
    [[self visibleCoins] removeObjectAtIndex:[(NSNumber *)[tempArray objectAtIndex:i] intValue]];
  }
}

-(void)dealloc
{
  [super dealloc];
  [[self visibleCoins] release];
}

@end
