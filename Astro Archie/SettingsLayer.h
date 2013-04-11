//
//  SettingsLayer.h
//  Astro Archie
//
//  Created by Ben Waxman on 03/04/2013.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuScene.h"
#import "assetManager.h"

@interface SettingsLayer : CCLayer {
  CCLayerColor *settingsLayer;
  CCMenu *settingsScreenMenu;
  NSUserDefaults* defaults;
  CCSprite *_controlSprite;
  CCSprite *_speedSprite;
  CCSprite *_highVisSprite;
  float _spriteXPos;
}

+(id)settingsLayerWithParentNode:(id)parentNode;

@end
