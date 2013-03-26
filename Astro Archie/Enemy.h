//
//  Enemy.h
//  Astro Archie
//
//  Created by Ben Waxman on 12/03/2013.
//
//

#import "CCNode.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "assetManager.h"

@interface Enemy : CCNode
{
}
@property(nonatomic,retain)CCSprite *sprite;

+(Enemy *)enemyWithParentNode:(id)parentNode;
-(id)initWithParentNode:(CCNode *)parentNode;
-(CGRect)spriteBox;
-(void)moveEnemy:(float)playerVelocity;

@end
