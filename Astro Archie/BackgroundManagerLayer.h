//
//  BackgroundManagerLayer.h
//  Astro Archie
//
//  Created by Luke Roberts on 21/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackgroundManagerLayer : CCLayer {
  int _bgIndex;
}
@property(nonatomic, retain)CCSprite *currentBG;
@property(nonatomic, retain)CCSprite *nextBG;

-(id)initWithParentNode:(id)parentNode;
-(void)increaseAltitudeWithVelocity:(float)velocity;
@end
