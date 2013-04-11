//
//  GameOver.h
//  Astro Archie
//
//  Created by Luke Roberts on 24/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "assetManager.h"

@interface GameOverScene : CCLayer {
}

-(id)initWithScore:(int)score andHeight:(float)height;

@end
