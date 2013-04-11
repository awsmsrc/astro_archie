//
//  EnemyUfo.m
//  Astro Archie
//
//  Created by Ben Waxman on 27/03/2013.
//
//

#import "EnemyUfo.h"

@implementation EnemyUfo

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aUfo]]];
    _screenSize = [[CCDirector sharedDirector] winSize];
    _SpeedOveride = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SpeedOveride"] floatValue];
    _ufoXVelocity = _SpeedOveride * (_screenSize.width/100);
    [self sprite].position = ccp(0.0f, _screenSize.height+50);
    [parentNode  addChild:self];
    [self addChild:self.sprite];
  }
  return self;
}

-(void)moveEnemy:(float)playerVelocity
{
  self.sprite.position = ccp(self.sprite.position.x + _ufoXVelocity, self.sprite.position.y - playerVelocity/3);
  //test for position at left or right of screen and reverse x speed
  if(self.sprite.position.x > _screenSize.width + self.spriteBox.size.width/2
     || self.sprite.position.x < -self.spriteBox.size.width/2)
    _ufoXVelocity *= -1;    
}

@end
