//
//  CoinManager.m
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoinManager.h"
#import "Coin.h"

@implementation CoinManager

-(id)initWithParentNode:(CCNode *)parentNode{
  if(self = [super init]){
    for(int i = 0; i < 1; i++){
      if((self = [super init])){
        Coin *coin = [[Coin alloc] initWithParentNode:parentNode];
      }
    }
  }
  return self;
}

@end
