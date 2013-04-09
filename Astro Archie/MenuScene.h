//
//  MenuScene.h
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SettingsLayer.h"

@interface MenuScene : CCLayer {
    
}

@property(nonatomic)Boolean menuEnabled;
+(id)scene;
-(void)enableMenu;

@end
