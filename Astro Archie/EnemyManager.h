//
//  EnemyManager.h
//  Astro Archie
//
//  Created by Ben Waxman on 12/03/2013.
//
//

#import "CCNode.h"
#import "Player.h"
#import "Enemy.h"
#import "EnemyMeteor.h"
#import "EnemyUfo.h"
#import "EnemyPlane.h"

@interface EnemyManager : CCNode
{
  float   _heightSinceLastEnemy;
  float   _randomDistanceVariance;
  bool    _active;
}

@property(nonatomic,retain)Enemy *currentEnemy;

-(id)initWithParentNode:(id)parentNode;
-(void)updateEnemiesInScene:(id)parentNode with:(Player *)player;
-(void)handleCollisionsWith:(Player *)player;
-(void)animateEnemy:(Player *)player;
-(void)addEnemy:(id)parentNode with:(Player *)player;

@end
