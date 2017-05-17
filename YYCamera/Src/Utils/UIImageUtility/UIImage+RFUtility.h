//
//  UIImage+RFUtility.h
//  tujiao
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import <UIKit/UIKit.h>

@interface UIImage (RFUtility)

- (UIImage*)crop:(CGRect)rect;
- (UIImage*)aspectFill:(CGSize)size;
- (UIImage*)aspectFill:(CGSize)size offset:(CGFloat)offset;

@end
