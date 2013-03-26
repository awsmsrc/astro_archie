//
//  SteeringInput.h
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SteeringInput : CCNode{
  id _delegate;
  id _userInput;
}
-(id)initForAccelerometerWithDelegate:(id)delegate;
-(id)initForTouchWithDelegate:(id)delegate;
-(id)initForFaceWithDelegate:(id)delegate;
-(id)deviceDidReturnValue;
@end
