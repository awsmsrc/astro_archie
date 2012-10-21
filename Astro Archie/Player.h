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
  CCSprite *_sprite;
  CGPoint _velocity;
}
-(id)initWithParentNode:(CCNode *)parentNode;
-(void)takeOff;
-(void)steerArchie;
@end
