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

@interface CollectablesManager : CCNode {
  CGPoint _highestCoin;
  CGSize _screenSize;
}

@property(nonatomic,retain)NSMutableArray *visibleCoins;
@property(nonatomic,retain)NSMutableArray *hiddenCoins;
@property(nonatomic,retain)NSMutableArray *ObjectsToTrash;

-(id)initWithParentNode:(id)parentNode;
-(void)handleCollisionsWith:(Player *)player;
-(void)animateCoins:(float)distance;
-(void)populateObjects;
-(void)drawRandomLine;
-(void)drawSquare;
-(void)drawCircle;
-(void)drawDiamond;
-(void)drawTriangle;
-(void)shuffleHidden;
-(void)addSpecial:(id)parentNode;
@end
