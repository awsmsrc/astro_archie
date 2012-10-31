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

@synthesize visibleObjects = _visibleObjects;
@synthesize hiddenObjects = _hiddenObects;

-(id)initWithParentNode:(id)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    
    //add coins to array
    //this should only fill the visible screen really
    for(int i=0; i < 100; i++){
      Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
      [[self visibleObjects] addObject:coin];
    }
    
    //add fuel to array
    for(int i=0; i < 20; i++){
      Fuel *fuel = [[Fuel alloc] initWithParentNode:parentNode];
      [[self visibleObjects] addObject:fuel];
    }
    
    //need to randomize order of object is array here
    for (NSUInteger i = 0; i < [[self visibleObjects] count]; ++i) {
      // Select a random element between i and end of array to swap with.
      int nElements = [[self visibleObjects] count] - i;
      int n = (random() % nElements) + i;
      [[self visibleObjects] exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    
    //set initial positions
    for(int i=0; i < [[self visibleObjects] count]; i ++){
      int x = arc4random()%440 + 20;
      int y = (arc4random()%100 + 50) + (i * 70);
      [[[self visibleObjects]objectAtIndex:i] sprite].position = ccp(x,y);
    }

  }
  return self;
}

-(NSMutableArray *)visibleObjects
{
  if(!_visibleObjects){
    _visibleObjects  = [[NSMutableArray alloc] init];
  }
  return _visibleObjects;
}

-(NSMutableArray *)hiddenObjects
{
  if(!_hiddenObects){
    _hiddenObects  = [[NSMutableArray alloc] init];
  }
  return _hiddenObects;
}


-(void)animateCoins:(int)distance
{
  for(Coin *coin in [self visibleObjects]){
    coin.sprite.position = ccp(coin.sprite.position.x, coin.sprite.position.y - distance);
  }
}

-(void)handleCollisionsWith:(Player *)player
{
  NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
  for(int i=0; i < [[self visibleObjects] count]; i++){
    if(CGRectIntersectsRect([player spriteBox], [[[self visibleObjects] objectAtIndex:i] spriteBox])){
      [player didCollideWithObject:[[self visibleObjects] objectAtIndex:i]];
      [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
      [[self hiddenObjects] addObject:[[self visibleObjects] objectAtIndex:i]];
      NSNumber *num = [NSNumber numberWithInt:i];
      [tempArray addObject:num];
    }
  }
  for(int i=0; i < [tempArray count]; i++){
    id token = [[self visibleObjects] objectAtIndex:(NSNumber *)[[tempArray objectAtIndex:i] intValue]];
    [token removeFromParentAndCleanup:NO];
    [[self visibleObjects] removeObjectAtIndex:[(NSNumber *)[tempArray objectAtIndex:i] intValue]];
  }
}

-(void)dealloc
{
  [super dealloc];
  [[self visibleObjects] release];
}

@end
