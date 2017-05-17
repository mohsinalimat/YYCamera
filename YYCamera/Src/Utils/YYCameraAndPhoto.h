//
//  YYCameraAndPhoto.h
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYCameraAndPhoto : NSObject

+ (UIImagePickerController *)getCameraPickerControllerIsFront:(BOOL)isFront;

+ (UIImagePickerController *)getPhotoLibraryPickerController;

+ (UIImage *)getScreenShotWithView:(UIView *)view isFullSize:(BOOL)isFullSize;

+ (UIImage *)getImageFromImage:(UIImage*) superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect;
@end
