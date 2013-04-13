//
//  helpLayer.m
//  Astro Archie
//
//  Created by Ben Waxman on 13/04/2013.
//
//

#import "helpLayer.h"
#import "SimpleAudioEngine.h"

@implementation helpLayer

-(id)initWithParentNode:(id)parentNode
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  if(self = [super init]){
    [parentNode addChild:self];    
    thisLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 255) width: screenSize.width height: screenSize.height];
    thisLayer.position = CGPointZero;
    [self addChild: thisLayer z:-2];
    
    _helpSprite = [[[CCSprite alloc] initWithFile:[[assetManager class] getSpriteFilepathFor:aHelpBackground]] autorelease];
    _helpSprite.anchorPoint = CGPointZero;
    _helpSprite.position = CGPointZero;
    [self addChild:_helpSprite z:-1];
    
    CCMenuItem *closeHelpMenuItem   = [CCMenuItemImage
                                           itemFromNormalImage:[[assetManager class] getButtonFilepathFor:back]
                                           selectedImage:[[assetManager class] getButtonFilepathFor:backPushed]
                                           target:self selector:@selector(closeHelpTapped:)];
    
    closeHelpMenuItem.position  = ccp(screenSize.width/2, 25);
    closeHelpMenuItem.scale = 0.75;
    
    helpScreenMenu = [CCMenu menuWithItems:
                          closeHelpMenuItem,
                          nil];
    helpScreenMenu.position = CGPointZero;
    [self addChild:helpScreenMenu z:0];
  }
  return self;
}

+(id)helpLayerWithParentNode:(id)parentNode
{
  return [[[helpLayer alloc] initWithParentNode:parentNode] autorelease];
}

-(void)closeHelpTapped:(id)sender{
  [self buttonPushed];
  [[self parent] enableMenu];
  [[self parent] removeChild:helpScreenMenu cleanup:YES];
  [[self parent] removeChild:thisLayer cleanup:YES];
  [self removeFromParentAndCleanup:YES];
}
-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}

@end
