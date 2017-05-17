
//
//  UIView+RFSize.m
//  tujiao
//
//  Created by Arvin on 15/11/26.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "UIView+RFSize.h"

@implementation UIView (RFSize)

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)leftAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.x += add;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)topAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.y += add;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}




- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)widthAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.width += add;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)heightAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.height += add;
    self.frame = frame;
}


- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end


// UIScrollerView___________________________
@implementation UIScrollView (warlee)
- (CGFloat)contentHeight {
    return self.contentSize.height;
}
- (void)setContentHeight:(CGFloat)height {
    CGSize size = self.contentSize;
    size.height = height;
    self.contentSize = size;
}
- (void)contentHeightAdd:(CGFloat)add {
    CGSize size = self.contentSize;
    size.height += add;
    self.contentSize = size;
}


- (CGFloat)contentWidth {
    return self.contentSize.width;
}
- (void)setContentWidth:(CGFloat)width{
    CGSize size = self.contentSize;
    size.width = width;
    self.contentSize = size;
}
- (void)contentWidthAdd:(CGFloat)add {
    CGSize size = self.contentSize;
    size.width += add;
    self.contentSize = size;
}

- (CGFloat)contentOffsetLeft {
    return self.contentOffset.x;
}
- (void)setContentOffsetLeft:(CGFloat) add {
    CGPoint point = self.contentOffset;
    point.x = add;
    self.contentOffset = point;
}
- (void)contentOffsetLeftAdd:(CGFloat) add {
    CGPoint point = self.contentOffset;
    point.x += add;
    self.contentOffset = point;
}


- (CGFloat)contentOffsetTop {
    return self.contentOffset.y;
}
- (void)setContentOffsetTop:(CGFloat) add {
    CGPoint point = self.contentOffset;
    point.y = add;
    self.contentOffset = point;
}
- (void)contentOffsetTopAdd:(CGFloat) add {
    CGPoint point = self.contentOffset;
    point.y += add;
    self.contentOffset = point;
}

@end

@implementation CALayer (EidanLayerSize)

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)leftAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.x += add;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)topAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.y += add;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}




- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)widthAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.width += add;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)heightAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.height += add;
    self.frame = frame;
}


- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)center {
    return CGPointMake(self.frame.origin.x + self.frame.size.width / 2, self.frame.origin.y + self.frame.size.height / 2);
}

- (void)setCenter:(CGPoint)center {
    CGRect frame = self.frame;
    
    frame.origin = CGPointMake(center.x - self.frame.size.width / 2, center.y - self.frame.size.height / 2);
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
