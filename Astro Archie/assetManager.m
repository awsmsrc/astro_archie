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
      filepath = @"coin.png"; //tempary placeholder sprites for enemies
      break;
    case aMeteor:
      filepath = @"coin.png";
      break;
    case aPlane:
      filepath = @"fuel.png";
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
@end
