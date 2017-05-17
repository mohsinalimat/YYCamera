
//
//  YYCameraAndPhoto.m
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "YYCameraAndPhoto.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation YYCameraAndPhoto

#pragma mark - Camera utility

+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

+ (UIImagePickerController *)getCameraPickerControllerIsFront:(BOOL)isFront
{
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isFrontCameraAvailable] && isFront) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        if (!isFront && [self isRearCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        
        return controller;
    }
    return nil;
}

+ (UIImagePickerController *)getPhotoLibraryPickerController
{
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        return controller;
    }
    return nil;
}

+ (UIImage *)getScreenShotWithView:(UIView *)view isFullSize:(BOOL)isFullSize
{
    CGSize imageSize = view.bounds.size;
    if (isFullSize) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }else{
        UIGraphicsBeginImageContext(imageSize);
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//图片裁剪,如果superImage是两倍图大小，然后你又想截取特定区域，subImageSize一般都为subImageRect.size,subImageRect可能都要乘以2，如果superImage不是两倍图大小，可能就不乘2.
+ (UIImage *)getImageFromImage:(UIImage*) superImage subImageSize:(CGSize)subImageSize subImageRect:(CGRect)subImageRect
{
    CGImageRef imageRef = superImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* returnImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext(); //返回裁剪的部分图像
    return returnImage;
}

@end
