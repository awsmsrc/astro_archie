//
//  SettingsLayer.m
//  Astro Archie
//
//  Created by Ben Waxman on 03/04/2013.
//

#import "SettingsLayer.h"
#import "MenuScene.h"
#import "SimpleAudioEngine.h"


@implementation SettingsLayer

-(id)initWithParentNode:(id)parentNode
{
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  if(self = [super init]){
    [parentNode addChild:self];
    defaults = [NSUserDefaults standardUserDefaults];
    settingsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 255) width: screenSize.width height: screenSize.height];
    settingsLayer.position = CGPointZero;
    
    int numButtons = 0;
    
    [self addChild: settingsLayer];
    CCMenuItem *TiltMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:@"resume.png" selectedImage:@"resume_pushed.png"
                                target:self selector:@selector(TiltControlTapped:)]; numButtons++;
    CCMenuItem *FaceMenuItem = [CCMenuItemImage
                                       itemFromNormalImage:@"resume.png" selectedImage:@"resume_pushed.png"
                                       target:self selector:@selector(FaceButtonTapped:)]; numButtons++;
    CCMenuItem *NormalSpeedMenuItem = [CCMenuItemImage
                                itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                                       target:self selector:@selector(normalSpeedTapped:)]; numButtons++;
    CCMenuItem *HalfSpeedMenuItem = [CCMenuItemImage
                                       itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                                       target:self selector:@selector(halfSpeedTapped:)]; numButtons++;
    CCMenuItem *SlowestSpeedMenuItem = [CCMenuItemImage
                                       itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                                       target:self selector:@selector(slowestSpeedTapped:)]; numButtons++;
    CCMenuItem *HighVisibilityMenuItem = [CCMenuItemImage
                                        itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                                        target:self selector:@selector(highVisibiltyTapped:)]; numButtons++;
    CCMenuItem *closeSettingsMenuItem = [CCMenuItemImage
                                         itemFromNormalImage:@"quit.png" selectedImage:@"quit_pushed.png"
                                         target:self selector:@selector(closeSettingsTapped:)]; numButtons++;
    
    float buttonStartPos = screenSize.height/2 -40;
    float buttonSpacing = screenSize.height/numButtons;
    int space = 0;
    
    TiltMenuItem.position           = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    FaceMenuItem.position           = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    NormalSpeedMenuItem.position    = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    HalfSpeedMenuItem.position      = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    SlowestSpeedMenuItem.position   = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    HighVisibilityMenuItem.position = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    closeSettingsMenuItem.position  = ccp(0, buttonStartPos - (buttonSpacing * space)); space++;
    
    settingsScreenMenu = [CCMenu menuWithItems: TiltMenuItem,
                                                FaceMenuItem,
                                                NormalSpeedMenuItem,
                                                HalfSpeedMenuItem,
                                                SlowestSpeedMenuItem,
                                                HighVisibilityMenuItem,
                                                closeSettingsMenuItem,
                                                nil];
    [settingsLayer addChild:settingsScreenMenu z:99999];
  }
  return self;
}

+(id)settingsLayerWithParentNode:(id)parentNode
{
  return [[[SettingsLayer alloc] initWithParentNode:parentNode] autorelease];
}

-(void)TiltControlTapped:(id)sender{
  [self buttonPushed];
  [defaults setObject:@"Tilt"
               forKey:@"Control"];
  NSLog( @"control = %@", [defaults stringForKey:@"Control"] );
}

-(void)FaceButtonTapped:(id)sender{
  [self buttonPushed];
  [defaults setObject:@"Face"
               forKey:@"Control"];
  NSLog( @"control = %@", [defaults stringForKey:@"Control"] );
}

-(void)normalSpeedTapped:(id)sender{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:1.0f]
               forKey:@"SpeedOveride"];
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)halfSpeedTapped:(id)sender{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:0.5f]
               forKey:@"SpeedOveride"];
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)slowestSpeedTapped:(id)sender{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:0.2f]
               forKey:@"SpeedOveride"];
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)highVisibiltyTapped:(id)sender{
  Boolean value = [[defaults valueForKey:@"HighVisibilty"] boolValue];
  [defaults setObject:[NSNumber numberWithBool:!value]
               forKey:@"HighVisibilty"];
  NSLog(@"value was %i, now is %i", value, [[defaults valueForKey:@"HighVisibilty"] boolValue]);
}

-(void)closeSettingsTapped:(id)sender{
  [self buttonPushed];
  [[self parent] enableMenu];
  [[self parent] removeChild:settingsScreenMenu cleanup:YES];
  [[self parent] removeChild:settingsLayer cleanup:YES];
  [self removeFromParentAndCleanup:YES];
  
  NSLog( @"control = %@", [defaults stringForKey:@"Control"] );
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}


@end

