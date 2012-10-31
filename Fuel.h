//
//  Fuel.h
//  Astro Archie
//
//  Created by Luke Roberts on 24/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Fuel : CCNode {
}
@property(nonatomic,retain)CCSprite *sprite;
+(Fuel *)fuelWithParentNode:(id)parentNode;
-(id)initWithParentNode:(CCNode *)parentNode;
-(CGRect)spriteBox;
@end
