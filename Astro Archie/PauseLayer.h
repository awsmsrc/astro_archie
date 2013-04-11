//
//  PauseLayer.h
//  Astro Archie
//
//  Created by Luke Roberts on 23/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "assetManager.h"

@interface PauseLayer : CCLayer {
  CCLayerColor *pauseLayer;
  CCMenu *pauseScreenMenu;
}

+(id)pauseLayerWithParentNode:(id)parentNode;

@end
