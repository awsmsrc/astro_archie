//
//  EnemyManager.m
//  Astro Archie
//
//  Created by Ben Waxman on 12/03/2013.
//
//

#import "EnemyManager.h"

@implementation EnemyManager

@synthesize currentEnemy = _currentEnemy;

-(id)initWithParentNode:(id)parentNode{
  if(self = [super init]){
    [parentNode addChild:self];
    _heightSinceLastEnemy = 0.0f;
    _currentEnemy = nil;
    _active = false;
  }
  return self;
}

-(void)updateEnemiesInScene:(id)parentNode with:(Player *)player
{
  [self addEnemy:parentNode with:player];
  [self animateEnemy:player];
  [self handleCollisionsWith:player];
}

-(void)handleCollisionsWith:(Player *)player
{
    if([self currentEnemy] != nil)
    {
      if(CGRectIntersectsRect([player spriteBox], [[self currentEnemy]spriteBox])){
        [player didCollideWithObject:[self currentEnemy]];
        _active = false;
        _heightSinceLastEnemy = player.height;
        [[self currentEnemy] removeFromParentAndCleanup:YES];
        self.currentEnemy = nil;
      }
    }
}
-(void)animateEnemy:(Player *)player
{
  if([self currentEnemy ] != nil){
    [[self currentEnemy ] moveEnemy:[player getYVelocity]];
    //if goes off the bottom of the screen
    if([self currentEnemy ].sprite.position.y < -100){
      _active = false;
      _heightSinceLastEnemy = player.height;
      [[self currentEnemy] removeFromParentAndCleanup:YES];
      self.currentEnemy = nil;
    }
  }
}
-(void)addEnemy:(id)parentNode with:(Player *)player
{
  float spawnDistance = 10000.0f;
  float lowEnemyThreshold = 40000.0f;
  float height = player.height;
  
    if( (height - _heightSinceLastEnemy) > spawnDistance && !_active )
  {
    int ID = -1;
    _active = true;
    //choose which enemy to spawn based on height
    if(height < lowEnemyThreshold )
      ID = 0;
    else
      ID = arc4random_uniform(2) + 1;
    //spawn the new enemy
    NSLog(@"spawned enemy type %i at height: %.2f",ID, height);
    switch (ID) {
      case 0:
        self.currentEnemy = [[[EnemyPlane alloc] initWithParentNode:parentNode] autorelease];
        break;
      case 1:
        self.currentEnemy = [[[EnemyMeteor alloc] initWithParentNode:parentNode] autorelease];
        break;
      case 2:
        self.currentEnemy = [[[EnemyUfo alloc] initWithParentNode:parentNode] autorelease];
        break;
      default:
        break;
    }//end of switch
  }
}

-(void)dealloc
{
  [super dealloc];
  [[self currentEnemy] removeFromParentAndCleanup:YES];
  //[[self currentEnemy] release];
}

@end
