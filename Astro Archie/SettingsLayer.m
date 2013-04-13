//
//  SettingsLayer.m
//  Astro Archie
//
//  Created by Ben Waxman on 03/04/2013.
//

#import "SettingsLayer.h"
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
    
    _controlSprite = [[[CCSprite alloc] initWithFile:[[assetManager class] getSpriteFilepathFor:aStar]] autorelease];
    _speedSprite = [[[CCSprite alloc] initWithFile:[[assetManager class] getSpriteFilepathFor:aStar]] autorelease];
    _highVisSprite = [[[CCSprite alloc] initWithFile:[[assetManager class] getSpriteFilepathFor:aStar]] autorelease];
    
    int numButtons = 0;
    
    [self addChild: settingsLayer];
    CCMenuItem *TiltMenuItem            = [CCMenuItemImage
                                            itemFromNormalImage:[[assetManager class] getButtonFilepathFor:tilt]
                                            selectedImage:[[assetManager class] getButtonFilepathFor:tiltPushed]
                                            target:self selector:@selector(TiltControlTapped:)]; numButtons++;
    CCMenuItem *FaceMenuItem            = [CCMenuItemImage
                                            itemFromNormalImage:[[assetManager class] getButtonFilepathFor:face]
                                            selectedImage:[[assetManager class] getButtonFilepathFor:facePushed]
                                            target:self selector:@selector(FaceButtonTapped:)]; numButtons++;
    CCMenuItem *NormalSpeedMenuItem     = [CCMenuItemImage
                                             itemFromNormalImage:[[assetManager class] getButtonFilepathFor:speedNormal]
                                             selectedImage:[[assetManager class] getButtonFilepathFor:speedNormalPushed]
                                             target:self selector:@selector(normalSpeedTapped:)]; numButtons++;
    CCMenuItem *HalfSpeedMenuItem       = [CCMenuItemImage
                                             itemFromNormalImage:[[assetManager class] getButtonFilepathFor:speedHalf]
                                             selectedImage:[[assetManager class] getButtonFilepathFor:speedHalfPushed]
                                             target:self selector:@selector(halfSpeedTapped:)]; numButtons++;
    CCMenuItem *SlowestSpeedMenuItem    = [CCMenuItemImage
                                             itemFromNormalImage:[[assetManager class] getButtonFilepathFor:speedFifth]
                                             selectedImage:[[assetManager class] getButtonFilepathFor:speedFifthPushed]
                                             target:self selector:@selector(slowestSpeedTapped:)]; numButtons++;
    CCMenuItem *HighVisibilityMenuItem  = [CCMenuItemImage
                                             itemFromNormalImage:[[assetManager class] getButtonFilepathFor:highVis]
                                             selectedImage:[[assetManager class] getButtonFilepathFor:highVisPushed]
                                             target:self selector:@selector(highVisibiltyTapped:)]; numButtons++;
    CCMenuItem *closeSettingsMenuItem   = [CCMenuItemImage
                                             itemFromNormalImage:[[assetManager class] getButtonFilepathFor:back]
                                             selectedImage:[[assetManager class] getButtonFilepathFor:backPushed]
                                             target:self selector:@selector(closeSettingsTapped:)]; numButtons++;
    
    float buttonStartPosY = screenSize.height - 30;
    float buttonPosX = screenSize.width/2;
    float buttonSpacing = screenSize.height/numButtons;
    int space = 0;
    
    TiltMenuItem.position           = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    FaceMenuItem.position           = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    NormalSpeedMenuItem.position    = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    HalfSpeedMenuItem.position      = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    SlowestSpeedMenuItem.position   = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    HighVisibilityMenuItem.position = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    closeSettingsMenuItem.position  = ccp(buttonPosX, buttonStartPosY - (buttonSpacing * space)); space++;
    
    //stars mark active buttons
    _spriteXPos = 20.0f;
    if([[defaults stringForKey:@"Control"] isEqual:@"Tilt"])
      _controlSprite.position = ccp(_spriteXPos, TiltMenuItem.position.y);
    else
      _controlSprite.position = ccp(_spriteXPos, FaceMenuItem.position.y);
    [self addChild:_controlSprite z:1];
    
    if([[defaults valueForKey:@"SpeedOveride"] floatValue] == 1.0f)
      _speedSprite.position  = ccp(_spriteXPos, NormalSpeedMenuItem.position.y);
    else if([[defaults valueForKey:@"SpeedOveride"] floatValue] == 0.5f)
      _speedSprite.position  = ccp(_spriteXPos, HalfSpeedMenuItem.position.y);
    else
      _speedSprite.position  = ccp(_spriteXPos, SlowestSpeedMenuItem.position.y);
    [self addChild:_speedSprite z:1];
    
    _highVisSprite.position = ccp(_spriteXPos, HighVisibilityMenuItem.position.y);
    _highVisSprite.visible = [[defaults valueForKey:@"HighVisibilty"] boolValue];
    [self addChild:_highVisSprite z:1];
    
    settingsScreenMenu = [CCMenu menuWithItems: TiltMenuItem,
                                                FaceMenuItem,
                                                NormalSpeedMenuItem,
                                                HalfSpeedMenuItem,
                                                SlowestSpeedMenuItem,
                                                HighVisibilityMenuItem,
                                                closeSettingsMenuItem,
                                                nil];
    settingsScreenMenu.position = CGPointZero;
    [settingsLayer addChild:settingsScreenMenu z:0];
  }
  return self;
}

+(id)settingsLayerWithParentNode:(id)parentNode
{
  return [[[SettingsLayer alloc] initWithParentNode:parentNode] autorelease];
}

-(void)TiltControlTapped:(CCMenuItem *)item{
  [self buttonPushed];
  [defaults setObject:@"Tilt"
               forKey:@"Control"];
  _controlSprite.position = ccp(_spriteXPos, item.position.y);
  NSLog( @"control = %@", [defaults stringForKey:@"Control"] );
}

-(void)FaceButtonTapped:(CCMenuItem *)item{
  [self buttonPushed];
  [defaults setObject:@"Face"
               forKey:@"Control"];
  _controlSprite.position = ccp(_spriteXPos, item.position.y);
  NSLog( @"control = %@", [defaults stringForKey:@"Control"] );
}

-(void)normalSpeedTapped:(CCMenuItem *)item{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:1.0f]
               forKey:@"SpeedOveride"];
  _speedSprite.position  = ccp(_spriteXPos, item.position.y);
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)halfSpeedTapped:(CCMenuItem *)item{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:0.5f]
               forKey:@"SpeedOveride"];
  _speedSprite.position  = ccp(_spriteXPos, item.position.y);
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)slowestSpeedTapped:(CCMenuItem *)item{
  [self buttonPushed];
  [defaults setObject:[NSNumber numberWithFloat:0.2f]
               forKey:@"SpeedOveride"];
  _speedSprite.position  = ccp(_spriteXPos, item.position.y);
  NSLog( @"speed = %f", [[defaults valueForKey:@"SpeedOveride"] floatValue]);
}

-(void)highVisibiltyTapped:(CCMenuItem *)item{
  Boolean value = [[defaults valueForKey:@"HighVisibilty"] boolValue];
  [defaults setObject:[NSNumber numberWithBool:!value]
               forKey:@"HighVisibilty"];
  _highVisSprite.visible = [[defaults valueForKey:@"HighVisibilty"] boolValue];
  NSLog(@"value was %i, now is %i", value, [[defaults valueForKey:@"HighVisibilty"] boolValue]);
}

-(void)closeSettingsTapped:(id)sender{
  [self buttonPushed];
  [[self parent] enableMenu];
  [[self parent] removeChild:settingsScreenMenu cleanup:YES];
  [[self parent] removeChild:settingsLayer cleanup:YES];
  [self removeFromParentAndCleanup:YES];
}

-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}


@end

