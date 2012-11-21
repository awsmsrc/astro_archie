//
//  HUDLayer.h
//  Astro Archie
//
//  Created by Luke Roberts on 14/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface HUDLayer : CCLayer {
  CCLabelTTF *scoreLabel;
  CCProgressTimer* fuelGuage;
}
-(id)initWithParentNode:(id)parentNode;
-(void)updateWithPlayer:(Player *)player;

@end
