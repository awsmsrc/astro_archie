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
@synthesize ObjectsToTrash = _ObjectsToTrash;

-(id)initWithParentNode:(id)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    _screenSize = [[CCDirector sharedDirector] winSize];
    _highestCoin = CGPointMake(0,_screenSize.height/2);
    for(int i=0; i < 30; i++){
      Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
      [coin sprite].position = CGPointMake(-100,-100);
      [[self hiddenCoins] addObject:coin];
    }
    for(int i=0; i < 5; i++){
      Fuel *fuel = [[Fuel alloc] initWithParentNode:parentNode];
      [fuel sprite].position = CGPointMake(-100,-100);
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
-(NSMutableArray *)ObjectsToTrash
{
  if(!_ObjectsToTrash){
    _ObjectsToTrash  = [[NSMutableArray alloc] init];
  }
  return _ObjectsToTrash;
}


-(void)animateCoins:(float)distance
{
  for(Coin *coin in [self visibleCoins]){
    coin.sprite.position = CGPointMake(coin.sprite.position.x, coin.sprite.position.y - distance);
    if(coin.sprite.position.y < -10)
    {
      coin.sprite.position = CGPointMake(-100, -100);
      if([coin isKindOfClass:[Special class]]){
        [[self ObjectsToTrash] addObject:coin];
      }
      else{
        [[self hiddenCoins] addObject:coin];
      }
    }
  }
  if([[self ObjectsToTrash] count] != 0 ){
    [[self visibleCoins] removeObjectsInArray:[self ObjectsToTrash]];
    [[self ObjectsToTrash] removeAllObjects];
  }
  [[self visibleCoins] removeObjectsInArray:[self hiddenCoins]];
  
  //move the recorded position of the highest object
  _highestCoin.y -= distance;
}

-(void)handleCollisionsWith:(Player *)player
{
  for(Coin* selectedCoin in [self visibleCoins]){
    if(CGRectIntersectsRect([player spriteBox], [selectedCoin spriteBox])){
      
      [player didCollideWithObject:selectedCoin];
      [[SimpleAudioEngine sharedEngine] playEffect:@"coin_collect.mp3"];
      selectedCoin.sprite.position = CGPointMake(-100, -100);
      
      if([selectedCoin isKindOfClass:[Special class]]){
        [[self ObjectsToTrash] addObject:selectedCoin];
      }
      else{        
        [[self hiddenCoins] addObject:selectedCoin];
      }
    }
  }
  if([[self ObjectsToTrash] count] != 0 ){
    [[self visibleCoins] removeObjectsInArray:[self ObjectsToTrash]];
    [[self ObjectsToTrash] removeAllObjects];
  }
  [[self visibleCoins] removeObjectsInArray:[self hiddenCoins]];
}

-(void)addSpecial:(id)parentNode{
  Special *special = [[Special alloc] initWithParentNode:parentNode];
  [[self hiddenCoins] addObject:special];
}

-(void)populateObjects{
  //NSLog(@"hidden: %i | visible: %i" ,[[self hiddenCoins] count],[[self visibleCoins] count]);
  if([[self hiddenCoins] count] >= 10){
    [self shuffleHidden];
    int randNum = arc4random_uniform(10);
    switch (randNum) {
      case 0:
        //[self drawCircle]; //circle code not working as expected
        //break;
      case 1:
        [self drawSquare];
        break;
      case 2:
        [self drawDiamond];
        break;
      case 3:
        [self drawTriangle];
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
    pos.x = arc4random_uniform(0.7 * _screenSize.width) + (0.15 * _screenSize.width);
    pos.y = arc4random_uniform(100) + _highestCoin.y;
    Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
    pos.y += selectedCoin.spriteBox.size.height;
    selectedCoin.sprite.position = pos;
    _highestCoin.y = pos.y + selectedCoin.spriteBox.size.height;
    [[self visibleCoins] addObject:selectedCoin];
  }
  _highestCoin.x = pos.x;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
}

-(void)drawSquare
{
  float largestSpriteHeight = 0;
  float largestSpriteWidth= 0;
  //get size info for spacing out the square so there is no overlapping sprites
  for(int i = 0; i < 9; i++){
    Coin *coin = [[self hiddenCoins] objectAtIndex:i];
    largestSpriteHeight = MAX(largestSpriteHeight, coin.spriteBox.size.height);
    largestSpriteWidth = MAX(largestSpriteWidth, coin.spriteBox.size.width);
  }
  //space it out a little more
  largestSpriteWidth *= 1.1;
  largestSpriteHeight *= 1.1;
  
  CGPoint startPos, pos;
  startPos.x = arc4random_uniform(0.7 *_screenSize.width) + (0.1 * _screenSize.width);
  startPos.y = (arc4random_uniform(50) + 50) + _highestCoin.y;
  //keep it all onscreen
  while((startPos.x + 3 * largestSpriteWidth) > _screenSize.width + (0.5 * largestSpriteWidth)){
    startPos.x -= largestSpriteWidth;
  }
  //draw the square
  int i = 0;
  for(int y=0; y < 3; y++){
    pos.y = startPos.y + (y * largestSpriteHeight);
    for(int x=0; x < 3; x++){
      Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
      pos.x = startPos.x + (x * largestSpriteWidth);
      selectedCoin.sprite.position = pos;
      [[self visibleCoins] addObject:selectedCoin];
      i++;
    }
  }
  _highestCoin.x = pos.x;
  _highestCoin.y = pos.y + arc4random_uniform(100) + largestSpriteHeight;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
}

-(void)drawCircle
{
  int numberOfObjects = 8;
  float largestSpriteHeight = 0;
  float largestSpriteWidth= 0;
  //get size info for spacing out the square so there is no overlapping sprites
  for(int i = 0; i < numberOfObjects; i++){
    Coin *coin = [[self hiddenCoins] objectAtIndex:i];
    largestSpriteHeight = MAX(largestSpriteHeight, coin.spriteBox.size.height);
    largestSpriteWidth = MAX(largestSpriteWidth, coin.spriteBox.size.width);
  }
  //space it out a little more
  largestSpriteWidth *= 1.1;
  largestSpriteHeight *= 1.1;
  
  CGPoint startPos, pos;
  startPos.x = arc4random_uniform(0.7 *_screenSize.width) + (0.1 * _screenSize.width);
  startPos.y = (arc4random_uniform(50) + 50) + _highestCoin.y + largestSpriteHeight;
  //keep the circle onscreen
  while((startPos.x + 2.5 * largestSpriteWidth) > _screenSize.width){
    startPos.x -= 0.5 * largestSpriteWidth;
  }
  while((startPos.x - 2.5 * largestSpriteWidth) < 0){
    startPos.x += 0.5 * largestSpriteWidth;
  }
  //start angle and stepping for circular distribution
  float angle = 0.0f;
  float angleStep = 360.0f/numberOfObjects;
  
  for(int i=0; i < numberOfObjects; i++){
    Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
    pos.x = startPos.x + (1.8 * largestSpriteWidth * cosf(angle));
    pos.y = startPos.y + (1.8 * largestSpriteWidth * sinf(angle));
    selectedCoin.sprite.position = pos;
    [[self visibleCoins] addObject:selectedCoin];
    angle += angleStep;
    NSLog(@"angle = %f", angle);
  }
  
  _highestCoin.x = startPos.x;
  _highestCoin.y = startPos.y + arc4random_uniform(100) + 2 * largestSpriteHeight;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
  
}

-(void)drawDiamond
{
  float largestSpriteHeight = 0;
  float largestSpriteWidth= 0;
  //get size info for spacing out the square so there is no overlapping sprites
  for(int i = 0; i < 9; i++){
    Coin *coin = [[self hiddenCoins] objectAtIndex:i];
    largestSpriteHeight = MAX(largestSpriteHeight, coin.spriteBox.size.height);
    largestSpriteWidth = MAX(largestSpriteWidth, coin.spriteBox.size.width);
  }
  //space it out a little more
  largestSpriteWidth *= 1.1;
  largestSpriteHeight *= 1.1;
  
  CGPoint pos;
  float startX;
  startX = arc4random_uniform(0.7 *_screenSize.width) + (0.1 * _screenSize.width);
  pos.y  = (arc4random_uniform(50) + 50) + _highestCoin.y;
  //keep it all onscreen
  while((startX + 1.5 * largestSpriteWidth) > _screenSize.width){
    startX -= 0.5 * largestSpriteWidth;
  }
  while((startX - 1.5 * largestSpriteWidth) < 0){
    startX += 0.5 * largestSpriteWidth;
  }
  //hidden object array index reference
  int i = 0;
  //bottom triangle 1/2
  for(int y=0; y < 2; ++y){
    for(int x=0; x <= y; ++x){
      Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
      pos.x = startX + (x * largestSpriteWidth);
      selectedCoin.sprite.position = pos;
      [[self visibleCoins] addObject:selectedCoin];
      i++;
    }
    startX -= 0.5 * largestSpriteWidth;
    pos.y += largestSpriteHeight;
  }  
  //top triangle 3/2/1
  for(int y=3; y > 0; --y){
    for(int x=0; x < y; ++x){
      Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
      pos.x = startX + (x * largestSpriteWidth);
      selectedCoin.sprite.position = pos;
      [[self visibleCoins] addObject:selectedCoin];
      i++;
    }
    startX += 0.5 * largestSpriteWidth;
    pos.y += largestSpriteHeight;
  }
  
  _highestCoin.x = pos.x;
  _highestCoin.y = pos.y + arc4random_uniform(100) + largestSpriteHeight;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];
}

-(void)drawTriangle
{
  float largestSpriteHeight = 0;
  float largestSpriteWidth= 0;
  //get size info for spacing out the square so there is no overlapping sprites
  for(int i = 0; i < 10; i++){
    Coin *coin = [[self hiddenCoins] objectAtIndex:i];
    largestSpriteHeight = MAX(largestSpriteHeight, coin.spriteBox.size.height);
    largestSpriteWidth = MAX(largestSpriteWidth, coin.spriteBox.size.width);
  }
  //space it out a little more
  largestSpriteWidth *= 1.1;
  largestSpriteHeight *= 1.1;
  
  CGPoint pos;
  float startX;
  startX = arc4random_uniform(0.7 *_screenSize.width) + (0.1 * _screenSize.width);
  pos.y  = (arc4random_uniform(50) + 50) + _highestCoin.y;
  //keep it all onscreen
  while((startX + 4 * largestSpriteWidth) > _screenSize.width + (0.5 * largestSpriteWidth)){
    startX -= 0.5 * largestSpriteWidth;
  }
  //hidden object array index reference
  int i = 0;
  //draw the triangle 4/3/2/1
  for(int y=4; y > 0; --y){
    for(int x=0; x < y; ++x){
      Coin *selectedCoin = [[self hiddenCoins] objectAtIndex:i];
      pos.x = startX + (x * largestSpriteWidth);
      selectedCoin.sprite.position = pos;
      [[self visibleCoins] addObject:selectedCoin];
      i++;
    }
    startX += 0.5 * largestSpriteWidth;
    pos.y += largestSpriteHeight;
  }
  
  _highestCoin.x = pos.x;
  _highestCoin.y = pos.y + arc4random_uniform(100) + largestSpriteHeight;
  [[self hiddenCoins] removeObjectsInArray:[self visibleCoins]];

}

-(void)dealloc
{
  [super dealloc];
  [[self visibleCoins] release];
  [[self hiddenCoins] release];
  [[self ObjectsToTrash] release];
}

@end
