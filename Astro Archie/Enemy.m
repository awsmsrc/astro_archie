//
//  Enemy.m
//  Astro Archie
//
//  Created by Ben Waxman on 12/03/2013.
//
//

#import "Enemy.h"

@implementation Enemy

@synthesize sprite = _sprite;

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aUfo]]];
    [self sprite].position = ccp(-100,-100);
    [parentNode  addChild:self];
    [self addChild:self.sprite];
  }
  return self;
}

+(id)enemyWithParentNode:(id)parentNode
{
  return [[[Enemy alloc] initWithParentNode:parentNode] autorelease];
}

-(CGRect)spriteBox
{
  return CGRectMake([self sprite].position.x - [[self sprite] texture].contentSize.width*[self sprite].anchorPoint.x,
                    [self sprite].position.y - [[self sprite] texture].contentSize.height*[self sprite].anchorPoint.y,
                    [[self sprite] texture].contentSize.width, [[self sprite] texture].contentSize.height);
}

-(void)moveEnemy:(float)playerVelocity
{
  
}

-(void)dealloc
{
  [super dealloc];
  [_sprite removeFromParentAndCleanup:YES];
  //[[self sprite] release];
  
}
@end
