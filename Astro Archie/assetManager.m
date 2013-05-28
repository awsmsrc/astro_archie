//
//  assetManager.m
//  Astro Archie
//
//  Created by Ben Waxman on 26/03/2013.
//
//

#import "assetManager.h"

@implementation assetManager

+(NSString *)getSpriteFilepathFor:(int)assetName
{
  NSString *filepath = [[[NSString alloc] init] autorelease];
  filepath = @"";
  
  // set for high visibility
  if([[[NSUserDefaults standardUserDefaults] valueForKey:@"HighVisibilty"] boolValue]){
    switch(assetName){
      case aArchie:
        filepath = @"highVisArchie.png";
        break;
      case aCoin:
        filepath = @"HighVisStar1.png";
        break;
      case aStar:
        filepath = @"HighVisStar1.png";
        break;
      case aFuel:
        filepath = @"HighVisFuel.png";
        break;
      case aSpecial:
        filepath = @"HighVisStar2.png";
        break;
      case aUfo:
        filepath = @"HighVisUfo.png";
        break;
      case aMeteor:
        filepath = @"HighVisAsteroid.png";
        break;
      case aPlane:
        filepath = @"HighVisBird.png";
        break;
      case aBGLayer0A:
        filepath = @"blackBox.png";
        break;
      case aBGLayer0B:
        filepath = @"blackBox.png";
        break;
      case aBGLayer0C:
        filepath = @"blackBox.png";
        break;
      case aBGLayer1:
        filepath = @"blackBox.png";
        break;
      case aBGLayer2:
        filepath = @"layer2.png";
        break;
      case aBGLayer3:
        filepath = @"layer3.png";
        break;
      case aStartMenuBackground:
        filepath = @"menubgTALL.png";
        break;
      case aEndMenuBackground:
        filepath = @"blackBox.png";
        break;
      case aHelpBackground:
        filepath = @"instructions.png";
        break;
      default:
        break;
    }
  }
  // set for normal visibility
  else{
    switch(assetName){
      case aArchie:
        filepath = @"newArchie.png";
        break;
      case aCoin:
         filepath = @"yellStar.png";
        break;
      case aStar:
          filepath = @"yellStar.png";
        break;
      case aFuel:
        filepath = @"fuelCan.png";
        break;
      case aSpecial:
        filepath = @"purpleStar.png";
        break;
      case aUfo:
        filepath = @"ufo.png";
        break;
      case aMeteor:
        filepath = @"asteroidsmall.png";
        break;
      case aPlane:
        filepath = @"birdtest2.png";
        break;
      case aBGLayer0A:
        filepath = @"layer0A.png";
        break;
      case aBGLayer0B:
        filepath = @"layer0B.png";
        break;
      case aBGLayer0C:
        filepath = @"layer0C.png";
        break;
      case aBGLayer1:
        filepath = @"layer1.png";
        break;
      case aBGLayer2:
        filepath = @"layer2.png";
        break;
      case aBGLayer3:
        filepath = @"layer3.png";
        break;
      case aStartMenuBackground:
        filepath = @"menubgTALL.png";
        break;
      case aEndMenuBackground:
        filepath = @"menubgTALL.png";
        break;
      case aHelpBackground:
        filepath = @"instructions.png";
        break;
      default:
        break;      
    }
  }
  return filepath;
}

+(NSString *)getButtonFilepathFor:(int)buttonName
{
  NSString *filepath = [[[NSString alloc] init] autorelease];
  filepath = @"";
  
  switch(buttonName){
    //main menu
    case play:
      filepath = @"playA.png";
      break;
    case playPushed:
      filepath = @"playB.png";
      break;
    case settings:
      filepath = @"settingsA.png";
      break;
    case settingsPushed:
      filepath = @"settingsB.png";
      break;
    case help:
      filepath = @"helpA.png";
      break;
    case helpPushed:
      filepath = @"helpB.png";
      break;
    //settings
    case tilt:
      filepath = @"tiltA.png";
      break;
    case tiltPushed:
      filepath = @"tiltB.png";
      break;
    case face:
      filepath = @"faceA.png";
      break;
    case facePushed:
      filepath = @"faceB.png";
      break;
    case speedNormal:
      filepath = @"speedNormalA.png";
      break;
    case speedNormalPushed:
      filepath = @"speedNormalB.png";
      break;
    case speedHalf:
      filepath = @"speedHalfA.png";
      break;
    case speedHalfPushed:
      filepath = @"speedHalfB.png";
      break;
    case speedFifth:
      filepath = @"speedFifthA.png";
      break;
    case speedFifthPushed:
      filepath = @"speedFifthB.png";
      break;
    case highVis:
      filepath = @"highVisA.png";
      break;
    case highVisPushed:
      filepath = @"highVisB.png";
      break;
    //general
    case back:
      filepath = @"backA.png";
      break;
    case backPushed:
      filepath = @"backB.png";
      break;
    case exitButton:
      filepath = @"exitA.png";
      break;
    case exitButtonPushed:
      filepath = @"exitB.png";
      break;
    //social
    case tweet:
      filepath = @"tweetA.png";
      break;
    case tweetPushed:
      filepath = @"tweetB.png";
      break;
    default:
      break;
  }
  return filepath;
}

@end
