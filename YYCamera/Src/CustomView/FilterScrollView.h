//
//  FilterScrollView.h
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import <UIKit/UIKit.h>

@interface FilterCell : UIView

@end

@interface FilterScollView : UIScrollView

@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIImageView *displayImageView;
@property (strong, nonatomic) NSArray *filterArray;

- (void)setUpWithOriginalImage:(UIImage *)image displayImageView:(UIImageView *)imageView andFilterArray:(NSArray *)array;

@end
