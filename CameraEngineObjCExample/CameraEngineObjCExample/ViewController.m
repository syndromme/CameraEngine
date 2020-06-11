//
//  ViewController.m
//  CameraEngineObjCExample
//
//  Created by syndromme on 11/06/20.
//  Copyright © 2020 syndromme. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.cameraEngine startSession];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.cameraEngine.rotationCamera = true;
}

- (void) viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  CALayer *layer = self.cameraEngine.previewLayer;
  if (layer) {
    return;
  }
  layer.frame = self.view.bounds;
  [self.view.layer insertSublayer:layer atIndex:0];
}

- (IBAction)setModeCapture:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"set mode capture" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.mode = ModeCapturePhoto;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.mode = ModeCaptureVideo;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)encoderSettingsPresset:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Encoder settings" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Preset640x480" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.videoEncoderPresset = CameraEngineVideoEncoderEncoderSettingsPreset640x480;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Preset960x540" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.videoEncoderPresset = CameraEngineVideoEncoderEncoderSettingsPreset960x540;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Preset1280x720" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.videoEncoderPresset = CameraEngineVideoEncoderEncoderSettingsPreset1280x720;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Preset1920x1080" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.videoEncoderPresset = CameraEngineVideoEncoderEncoderSettingsPreset1920x1080;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Preset3840x2160" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.videoEncoderPresset = CameraEngineVideoEncoderEncoderSettingsPreset3840x2160;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)setZoomCamera:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"set zoom factor" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"X1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraZoomFactor = 1;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"X2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraZoomFactor = 2;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"X3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraZoomFactor = 3;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"X4" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraZoomFactor = 4;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"X5" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraZoomFactor = 5;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)setFocus:(id)sender {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"set focus settings" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Locked" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraFocus = CameraEngineCameraFocusLocked;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"auto focus" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraFocus = CameraEngineCameraFocusAutoFocus;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"continious auto focus" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    self.cameraEngine.cameraFocus = CameraEngineCameraFocusContinuousAutoFocus;
  }]];
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
  [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)switchCamera:(id)sender {
  [self.cameraEngine switchCurrentDevice];
}

- (IBAction)takePhoto:(id)sender {
  if (self.mode == ModeCapturePhoto) {
    [self.cameraEngine capturePhoto:^(UIImage * _Nullable image, NSError * _Nullable error) {
      if (error) {
        
      } else if (image) {
        [CameraEngineFileManager savePhoto:image blockCompletion:^(BOOL success, NSError * _Nullable error) {
          if (error) {
            
          } else if (success) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success, image saved !" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:true completion:nil];
          }
        }];
      }
    }];
  } else if (self.mode = ModeCaptureVideo) {
    if (!self.cameraEngine.isRecording) {
      NSURL *url = [CameraEngineFileManager temporaryPath:@"video.mp4"];
      [self.cameraEngine startRecordingVideo:url blockCompletion:^(NSURL * _Nullable url, NSError * _Nullable error) {
        if (url) {
          dispatch_async(dispatch_get_main_queue(), ^{
            [CameraEngineFileManager saveVideo:url blockCompletion:^(BOOL success, NSError * _Nullable error) {
              if (success) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success, video saved !" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:true completion:nil];
              }
            }];
          });
        }
      }];
    } else {
      [self.cameraEngine stopRecordingVideo];
    }
  }
}

@end
