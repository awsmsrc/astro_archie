//
//  AccellerometerInput.h
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AccellerometerInput : CCLayer{
  id _delegate;
}

-(id)initWithDelegate:(id)delegate;

@end
