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
  
  //for our current iPhone config
  //could do multiple switches for the different platform assets
  switch(assetName){
    case aArchie:
      filepath = @"archie.png";
      break;
    case aCoin:
       filepath = @"starY.png";
      break;
    case aStar:
        filepath = @"starY.png";
      break;
    case aFuel:
      filepath = @"fuel.png";
      break;
    case aSpecial:
      filepath = @"starP.png";
      break;
    case aUfo:
      filepath = @"ufo.png";
      break;
    case aMeteor:
      filepath = @"asteroid.png";
      break;
    case aPlane:
      filepath = @"birdtest2.png";
      break;
    case aBackground1:
      filepath = @"bg1.png";
      break;
    case aBackground2:
      filepath = @"bg2.png";
      break;
    case aBackground3:
      filepath = @"bg3.png";
      break;
    default:
      break;      
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
