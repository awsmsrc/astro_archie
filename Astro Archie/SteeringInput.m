//
//  SteeringInput.m
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import "SteeringInput.h"
#import "AccellerometerInput.h"
#import "FaceInput.h"

@implementation SteeringInput

-(id)initForAccelerometerWithDelegate:(id)delegate{
  NSLog(@"Steering Input Init");
  if(self = [super init]){
    //[self addChild: [[AccellerometerInput alloc] initWithDelegate:(id)delegate]];
    [self addChild: [[FaceInput alloc] initWithDelegate:(id)delegate]];
  }
  return self;
}

@end
