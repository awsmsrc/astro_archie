//
//  BackgroundManagerLayer.h
//  Astro Archie
//
//  Created by Luke Roberts on 21/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "assetManager.h"

@interface BackgroundManagerLayer : CCLayer {
  int _bgIndex;
  float BG1Height, BG2Height;
}
@property(nonatomic, retain)CCSprite *BG1;
@property(nonatomic, retain)CCSprite *BG2;

-(id)initWithParentNode:(id)parentNode;
-(void)increaseAltitudeWithVelocity:(float)velocity;
-(void)swapBackgroundSprite:(int)BGNo with:(NSString*)filename;
@end
