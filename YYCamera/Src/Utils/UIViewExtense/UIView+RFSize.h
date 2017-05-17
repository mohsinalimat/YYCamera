//
//  UIView+RFSize.h
//  tujiao
//
//  Created by Arvin on 15/11/26.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import <UIKit/UIKit.h>

@interface UIView (RFSize)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)topAdd:(CGFloat)add;
- (void)leftAdd:(CGFloat)add;
- (void)widthAdd:(CGFloat)add;
- (void)heightAdd:(CGFloat)add;
@end

@interface CALayer (EidanLayerSize)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGSize size;

- (void)topAdd:(CGFloat)add;
- (void)leftAdd:(CGFloat)add;
- (void)widthAdd:(CGFloat)add;
- (void)heightAdd:(CGFloat)add;
@end

@interface UIScrollView (EidanScrollView)

@property (nonatomic) CGFloat contentHeight;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentOffsetLeft;
@property (nonatomic) CGFloat contentOffsetTop;

- (void)contentHeightAdd:(CGFloat)add;
- (void)contentWidthAdd:(CGFloat)add;
- (void)contentOffsetLeftAdd:(CGFloat)add;
- (void)contentOffsetTopAdd:(CGFloat)add;

@end
