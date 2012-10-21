//
//  Coin.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Coin.h"


@implementation Coin

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    _sprite = [CCSprite spriteWithFile:@"coin.png"];
    _sprite.position = ccp(160,200);
    [parentNode addChild:_sprite];
  }
}

-(void)dealloc
{
  [super dealloc];
  [_sprite removeFromParentAndCleanup:YES];
  _sprite = nil;
}

@end
