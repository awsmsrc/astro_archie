//
//  helpLayer.h
//  Astro Archie
//
//  Created by Ben Waxman on 13/04/2013.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuScene.h"
#import "assetManager.h"

@interface helpLayer : CCLayer{
  CCLayerColor *thisLayer;
  CCSprite *_helpSprite;
  CCMenu *helpScreenMenu;
}

+(id)helpLayerWithParentNode:(id)parentNode;

@end
