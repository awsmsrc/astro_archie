//
//  assetManager.h
//  Astro Archie
//
//  Created by Ben Waxman on 26/03/2013.
//
//

#import <Foundation/Foundation.h>

@interface assetManager : NSObject

enum{
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

+(NSString *)getSpriteFilepathFor:(int)assetName;

@end
