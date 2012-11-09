//
//  Special.h
//  Astro Archie
//
//  Created by Ben Waxman on 08/11/2012.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Special : CCNode {  
}
@property(nonatomic,retain)CCSprite *sprite;
@property float _bonusPoints;
@property float _bonusFuel;
@property float _bonusSpeed; 
+(Special *)SpecialWithParentNode:(id)parentNode;
-(id)initWithParentNode:(CCNode *)parentNode;
-(CGRect)spriteBox;
@end