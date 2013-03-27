//
//  Coin.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Coin.h"


@implementation Coin

@synthesize sprite = _sprite;

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aCoin]]];
    [self sprite].position = ccp(160,300);
    [parentNode  addChild:self];
    [self addChild:_sprite];
  }
  return self;
}

+(id)coinWithParentNode:(id)parentNode
{
  return [[[Coin alloc] initWithParentNode:parentNode] autorelease];
}

-(CGRect)spriteBox
{
  return CGRectMake([self sprite].position.x - [[self sprite] texture].contentSize.width*[self sprite].anchorPoint.x,
                    [self sprite].position.y - [[self sprite] texture].contentSize.height*[self sprite].anchorPoint.y,
                    [[self sprite] texture].contentSize.width, [[self sprite] texture].contentSize.height);
}

-(void)dealloc
{
  [super dealloc];
  [_sprite removeFromParentAndCleanup:YES];
  //[[self sprite] release];

}

@end
