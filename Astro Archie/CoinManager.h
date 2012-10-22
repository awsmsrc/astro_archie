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
}

@property(nonatomic,retain)NSMutableArray *visibleCoins;

-(id)initWithParentNode:(CCNode *)parentNode;
-(void)handleCollisionsWith:(Player *)player;
-(void)animateCoins:(int)distance;

@end
