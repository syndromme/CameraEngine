//
//  ViewController.h
//  CameraEngineObjCExample
//
//  Created by syndromme on 11/06/20.
//  Copyright © 2020 syndromme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CameraEngine/CameraEngine-Swift.h>

typedef NS_ENUM(NSInteger, ModeCapture) {
   ModeCapturePhoto = 0,
   ModeCaptureVideo = 1,
};

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cameraModeButton;
@property (weak, nonatomic) IBOutlet UILabel *cameraModeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shutterButton;

@property (strong, nonatomic) CameraEngine *cameraEngine;
@property (assign, nonatomic) ModeCapture *mode;
@end

