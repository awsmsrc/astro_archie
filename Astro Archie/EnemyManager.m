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
    _screenSize = [[CCDirector sharedDirector] winSize];
    _heightSinceLastEnemy = 0.0f;
    _currentEnemy = NULL;
    _active = false;
  }
  return self;
}

-(void)updateEnemiesInScene:(id)parentNode with:(Player *)player
{
  [self addEnemy:parentNode with:player];
  [self animateEnemy:player.getYVelocity];
  [self handleCollisionsWith:player];
}

-(void)handleCollisionsWith:(Player *)player
{
    if([self currentEnemy] != NULL)
    {
      if(CGRectIntersectsRect([player spriteBox], [[self currentEnemy]spriteBox])){
        [player didCollideWithObject:[self currentEnemy]];
        _active = false;
      }
    }
}
-(void)animateEnemy:(float)playerVelocity
{
  if([self currentEnemy ] != NULL){
    [[self currentEnemy ] moveEnemy:playerVelocity];
    //if goes off the bottom of the screen
    if([self currentEnemy ].sprite.position.y < -100){
      _active = false;
      [[self currentEnemy] removeFromParentAndCleanup:YES];
      [[self currentEnemy] release];
    }
  }
}
-(void)addEnemy:(id)parentNode with:(Player *)player
{
  float spawnDistance = 10000.0f;
  float lowEnemyThreshold = 25000.0f;  
  float height = player.height;
  
    if( (height - _heightSinceLastEnemy) > spawnDistance && !_active )
  {
    int ID = -1;
    _heightSinceLastEnemy = height;
    //_active = true; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<uncomment when enemy classess added
    //choose which enemy to spawn based on height
    if(height < lowEnemyThreshold )
      ID = 0;
    else
      ID = arc4random_uniform(2) + 1;
    //spawn the new enemy
    NSLog(@"spawned enemy type %i at height: %.2f",ID, height);
    switch (ID) {
      case 0:
        //currentEnemy = new low enemy (below threshold only)
        break;
      case 1:
        //currentEnemy = new mid enemy (only above threshold)
        break;
      case 2:
        //currentEnemy = new high enemy (only above threshold)
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
  [[self currentEnemy] release];  
}

@end
