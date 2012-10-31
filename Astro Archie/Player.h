//
//  Player.h
//  Astro Archie
//
//  Created by Luke Roberts on 18/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCNode {
  CGPoint _velocity;
  int _score;
  float _fuel;
}
@property(nonatomic, retain)CCSprite *sprite;
-(id)initWithParentNode:(CCNode *)parentNode;
-(void)takeOff;
-(void)didCollideWithObject:(id)object;
-(void)steerArchie;
-(void)incrementScore;
-(int)score;
-(void)decrementFuel;
-(float)fuel;
-(CGRect)spriteBox;
@end
