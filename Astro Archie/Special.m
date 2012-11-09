//
//  Special.m
//  Astro Archie
//
//  Created by Ben Waxman on 08/11/2012.
//
//

#import "Special.h"

@implementation Special

@synthesize sprite = _sprite;


-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:@"starP.png"]];
    [self sprite].position = ccp(-100,-100);
    [parentNode  addChild:self];
    [self addChild:_sprite];
    self._bonusFuel = 100;
    self._bonusPoints = 1000;
    self._bonusSpeed = 2;
  }
  return self;
}

+(id)SpecialWithParentNode:(id)parentNode
{
  return [[[Special alloc] initWithParentNode:parentNode] autorelease];
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
  [[self sprite] release];
  
}

@end
