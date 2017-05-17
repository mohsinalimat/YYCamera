//
//  RFStickerView.h
//  tujiao
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import <UIKit/UIKit.h>

@interface RFStickerView : UIView

@property (strong, nonatomic) UIImageView *contentImageView;
@property (strong, nonatomic) UIImage *tempOriginImage;

- (void)displayCustomView:(BOOL)isDisplay;

@end
