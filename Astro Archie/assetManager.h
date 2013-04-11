//
//  assetManager.h
//  Astro Archie
//
//  Created by Ben Waxman on 26/03/2013.
//
//

#import <Foundation/Foundation.h>

@interface assetManager : NSObject

enum sprites{
  aArchie  = 0,
  aCoin    = 1,
  aStar    = 2,
  aFuel    = 3,
  aSpecial = 4,
  aUfo     = 5,
  aMeteor  = 6,
  aPlane   = 7,
  aBackground1 = 8,
  aBackground2 = 9,
  aBackground3 = 10
};

enum buttontypes{
  //main menu
  play,
  playPushed,
  settings,
  settingsPushed,
  //settings
  tilt,
  tiltPushed,
  face,
  facePushed,
  speedNormal,
  speedNormalPushed,
  speedHalf,
  speedHalfPushed,
  speedFifth,
  speedFifthPushed,
  highVis,
  highVisPushed,
  //general
  back,
  backPushed,
  exitButton,
  exitButtonPushed,
  //social
  tweet,
  tweetPushed
};

+(NSString *)getSpriteFilepathFor:(int)assetName;
+(NSString *)getButtonFilepathFor:(int)buttonName;

@end
