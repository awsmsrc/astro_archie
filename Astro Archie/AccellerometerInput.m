//
//  AccellerometerInput.m
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import "AccellerometerInput.h"

@implementation AccellerometerInput

-(id)initWithDelegate:(id)delegate{
  if(self = [super init]){
    NSLog(@"accellerometer input init");
    self.isAccelerometerEnabled = YES;
    _delegate = delegate;
  }
  return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  
  NSNumber *acc = [NSNumber numberWithFloat:acceleration.x];
  [_delegate applyAcceleration:acc];
}
@end
