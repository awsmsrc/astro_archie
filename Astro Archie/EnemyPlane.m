//
//  EnemyPlane.m
//  Astro Archie
//
//  Created by Ben Waxman on 27/03/2013.
//
//

#import "EnemyPlane.h"

@implementation EnemyPlane

-(id)initWithParentNode:(CCNode *)parentNode{
  if((self = [super init])){
    [self setSprite:[CCSprite spriteWithFile:[[assetManager class] getSpriteFilepathFor:aPlane]]];
    _screenSize = [[CCDirector sharedDirector] winSize];
    _SpeedOveride = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SpeedOveride"] floatValue];
    _planeXVelocity = _SpeedOveride * (_screenSize.width/150);
    //only change the scale if sprite is facing to the left to make it face right.
    self.sprite.scaleX = -1;
    ////////////////////////////////////////////////////////////////////////
    [self sprite].position = ccp(0.0f, _screenSize.height+50);
    [parentNode  addChild:self];
    [self addChild:self.sprite];
  }
  return self;
}

-(void)moveEnemy:(float)playerVelocity
{
  self.sprite.position = ccp(self.sprite.position.x + _planeXVelocity, self.sprite.position.y - playerVelocity/3);
  //test for right side of screen, reverse x speed and turn the plane
  if(self.sprite.position.x > _screenSize.width + self.spriteBox.size.width){
    _planeXVelocity *= -1;
    self.sprite.scaleX = 1;
  }
  //test for left side of screen,  reverse x speed and turn the plane
  else if (self.sprite.position.x < -self.spriteBox.size.width){
    _planeXVelocity *= -1;
    self.sprite.scaleX = -1;
  }
    
}

@end
