//
//  Coin.h
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Coin : CCNode {
  CCSprite *_sprite;
}

-(id)initWithParentNode:(CCNode *)parentNode;

@end