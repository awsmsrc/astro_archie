//
//  CoinManager.h
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface CoinManager : CCNode {
  CCArray *visibleCoins;
  CCArray *queuedCoins;
}

-(id)initWithParentNode:(CCNode *)parentNode;
-(id)handleCollisionsWith:(Player *)player;

@end
