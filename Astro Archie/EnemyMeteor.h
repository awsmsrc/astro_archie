//
//  EnemyMeteor.h
//  Astro Archie
//
//  Created by Ben Waxman on 27/03/2013.
//
//

#import "Enemy.h"

@interface EnemyMeteor : Enemy{
  CCParticleSystem  *flameEmitter;
}

@property(nonatomic,retain)CCSprite *sprite;
-(CCParticleSystem *)flameEffect;
@end
