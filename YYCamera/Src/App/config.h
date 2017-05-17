
//
//  config.h
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#ifndef config_h
#define config_h

#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

#define RGBA(R, G, B, A)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B)              [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define StickerOperationInsertRectOffset         15 //贴纸操作按钮的宽高为30 次为一半 增加操作按钮的响应区域


#endif /* config_h */
