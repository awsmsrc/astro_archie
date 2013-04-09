//
//  AccellerometerInput.m
//  Astro Archie
//
//  Created by Luke Roberts on 06/03/2013.
//
//

#import "FaceInput.h"

@implementation FaceInput


-(id)initWithDelegate:(id)delegate{
  if(self = [super init]){
    NSLog(@"face input init");
    _delegate = delegate;
    NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
    self.faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    [self initFaceDetector];
  }
  return self;
}

-(void)initFaceDetector{
  NSError *error = nil;
  
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    [session setSessionPreset:AVCaptureSessionPreset640x480];
	} else {
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
	}
  
  // Select a video device, make an input
	AVCaptureDevice *device;
  
  AVCaptureDevicePosition desiredPosition = AVCaptureDevicePositionFront;
  
  // find the front facing camera
	for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
		if ([d position] == desiredPosition) {
			device = d;
			break;
		}
	}
  // fall back to the default camera.
  if( nil == device )
  {
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  }
  
  // get the input device
  AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
  
	if( !error ) {
    
    // add the input to the session
    if ( [session canAddInput:deviceInput] ){
      [session addInput:deviceInput];
    }
    
    
    // Make a video data output
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    // we want BGRA, both CoreGraphics and OpenGL work well with 'BGRA'
    NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
                                       [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [self.videoDataOutput setVideoSettings:rgbOutputSettings];
    [self.videoDataOutput setAlwaysDiscardsLateVideoFrames:YES]; // discard if the data output queue is blocked
    
    // create a serial dispatch queue used for the sample buffer delegate
    // a serial dispatch queue must be used to guarantee that video frames will be delivered in order
    // see the header doc for setSampleBufferDelegate:queue: for more information
    self.videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [self.videoDataOutput setSampleBufferDelegate:self queue:self.videoDataOutputQueue];
    
    if ( [session canAddOutput:self.videoDataOutput] ){
      [session addOutput:self.videoDataOutput];
    }
    
    // get the output for doing face detection.
    [[self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo] setEnabled:YES];
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    self.previewLayer.backgroundColor = [[UIColor blackColor] CGColor];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [session startRunning];
    
  }
	session = nil;
	if (error) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:
                              [NSString stringWithFormat:@"Failed with error %d", (int)[error code]]
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
		[alertView show];
		[self teardownAVCapture];
	}
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
	// get the image
	CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
	CIImage *ciImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer
                                                    options:(__bridge NSDictionary *)attachments];
	if (attachments) {
		CFRelease(attachments);
  }
  
  // make sure your device orientation is not locked.
	UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
  
	NSDictionary *imageOptions = nil;
  
	imageOptions = [NSDictionary dictionaryWithObject:[self exifOrientation:curDeviceOrientation]
                                             forKey:CIDetectorImageOrientation];
  
	NSArray *features = [self.faceDetector featuresInImage:ciImage
                                                 options:imageOptions];
  
  // get the clean aperture
  // the clean aperture is a rectangle that defines the portion of the encoded pixel dimensions
  // that represents image data valid for display.
	CMFormatDescriptionRef fdesc = CMSampleBufferGetFormatDescription(sampleBuffer);
	CGRect cleanAperture = CMVideoFormatDescriptionGetCleanAperture(fdesc, false /*originIsTopLeft == false*/);
  
	dispatch_async(dispatch_get_main_queue(), ^(void) {
    if([features count] > 0){
      CIFaceFeature *ff = [features firstObject];
      CGRect faceRect = [ff bounds];
      CGFloat temp = faceRect.origin.y;
      float val = ((140.0 - temp)/200.0);
      NSLog(@"%f", val);
      NSNumber *acceleration = [NSNumber numberWithFloat:val];
      [_delegate applyAcceleration:acceleration];
      
    
      //NSLog(@"%@", NSStringFromCGRect(faceRect));
      // NSLog(@"%@", NSStringFromCGPoint(faceRect.origin));
    }
	});
}

- (NSNumber *) exifOrientation: (UIDeviceOrientation) orientation
{
	int exifOrientation;
  /* kCGImagePropertyOrientation values
   The intended display orientation of the image. If present, this key is a CFNumber value with the same value as defined
   by the TIFF and EXIF specifications -- see enumeration of integer constants.
   The value specified where the origin (0,0) of the image is located. If not present, a value of 1 is assumed.
   
   used when calling featuresInImage: options: The value for this key is an integer NSNumber from 1..8 as found in kCGImagePropertyOrientation.
   If present, the detection will be done based on that orientation but the coordinates in the returned features will still be based on those of the image. */
  
	enum {
		PHOTOS_EXIF_0ROW_TOP_0COL_LEFT			= 1, //   1  =  0th row is at the top, and 0th column is on the left (THE DEFAULT).
		PHOTOS_EXIF_0ROW_TOP_0COL_RIGHT			= 2, //   2  =  0th row is at the top, and 0th column is on the right.
		PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT      = 3, //   3  =  0th row is at the bottom, and 0th column is on the right.
		PHOTOS_EXIF_0ROW_BOTTOM_0COL_LEFT       = 4, //   4  =  0th row is at the bottom, and 0th column is on the left.
		PHOTOS_EXIF_0ROW_LEFT_0COL_TOP          = 5, //   5  =  0th row is on the left, and 0th column is the top.
		PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP         = 6, //   6  =  0th row is on the right, and 0th column is the top.
		PHOTOS_EXIF_0ROW_RIGHT_0COL_BOTTOM      = 7, //   7  =  0th row is on the right, and 0th column is the bottom.
		PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM       = 8  //   8  =  0th row is on the left, and 0th column is the bottom.
	};
  
	switch (orientation) {
		case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
			exifOrientation = PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM;
			break;
		case UIDeviceOrientationLandscapeLeft:       // Device oriented horizontally, home button on the right
				exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
			break;
		case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
				exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
		case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
		default:
			exifOrientation = PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP;
			break;
	}
  return [NSNumber numberWithInt:exifOrientation];
}

@end
