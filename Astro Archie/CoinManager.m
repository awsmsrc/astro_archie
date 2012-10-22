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

-(id)initWithParentNode:(CCNode *)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
    [[self visibleCoins] addObject:coin];
    [self scheduleUpdate];
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

-(void)update:(ccTime)delta
{
  //no op
}

-(void)animateCoins:(int)distance
{
  for(Coin *coin in [self visibleCoins]){
    coin.sprite.position = ccp(coin.sprite.position.x, coin.sprite.position.y - distance);
  }
}

-(void)handleCollisionsWith:(Player *)player
{
  for(Coin *coin in [self visibleCoins]){
    if(CGRectIntersectsRect([player spriteBox], [coin spriteBox])){
      NSLog(@"collision");
      coin.sprite.visible = NO;
      [coin.sprite.parent removeChild:coin cleanup:YES];
      [[self visibleCoins] removeObject:coin];
      [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
    }
  }
}

-(void)dealloc
{
  [super dealloc];
  [[self visibleCoins] release];
}

@end
