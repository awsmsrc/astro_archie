//
//  FaceInput.h
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

@interface FaceInput : CCLayer <AVCaptureVideoDataOutputSampleBufferDelegate>{
  id _delegate;
}

@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) dispatch_queue_t videoDataOutputQueue;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) UIImage *borderImage;
@property (nonatomic, strong) CIDetector *faceDetector;

+(id)initWithDelegate:(id)delegate;

@end