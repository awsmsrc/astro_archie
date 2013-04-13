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
  aCoin,
  aStar,
  aFuel,
  aSpecial,
  aUfo,
  aMeteor,
  aPlane,
  aBGLayer0A,
  aBGLayer0B,
  aBGLayer0C,
  aBGLayer1,
  aBGLayer2,
  aBGLayer3,
  aStartMenuBackground,
  aEndMenuBackground,
  aHelpBackground
};

enum buttontypes{
  //main menu
  play,
  playPushed,
  settings,
  settingsPushed,
  help,
  helpPushed,
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
