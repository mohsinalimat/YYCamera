
//
//  FilterScrollView.m
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "FilterScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "config.h"
#import "UIView+RFSize.h"
#import "UIImage+RFUtility.h"

#define CellWidth           70
#define CellHeight          100

@interface FilterCell()

@property (nonatomic, strong) NSString *filterKey;
@property (nonatomic, strong) NSString *title;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *filterId;

@end

@implementation FilterCell

@end


@interface FilterScollView ()

@property (strong, nonatomic) NSMutableArray *cellsArray;

@end

@implementation FilterScollView

- (void)setUpWithOriginalImage:(UIImage *)image displayImageView:(UIImageView *)imageView andFilterArray:(NSArray *)array
{
    self.originalImage = image;
    self.displayImageView = imageView;
    self.filterArray = array;
    
    self.cellsArray = [NSMutableArray array];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    CGFloat left = 10;
    
    for (int i = 0; i < self.filterArray.count; i++) {
        FilterCell *cell = [[FilterCell alloc] initWithFrame:CGRectMake(left*(i+1)+CellWidth*i, 5, CellWidth, CellHeight-10)];
        cell.filterKey = [self.filterArray objectAtIndex:i];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CellWidth, CellHeight)];
        iconView.clipsToBounds = YES;
        iconView.layer.cornerRadius = 5;
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView = iconView;
        [cell addSubview:iconView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedFilterCell:)];
        [cell addGestureRecognizer:gesture];
        
        [self addSubview:cell];
        [self.cellsArray addObject:cell];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *iconImage = [self filteredImage:self.originalImage withFilterName:cell.filterKey];
            [iconView performSelectorOnMainThread:@selector(setImage:) withObject:iconImage waitUntilDone:NO];
        });
        
    }
    self.contentWidth = CellWidth * (self.filterArray.count + 1);
}

-(void)setOriginalImage:(UIImage *)originalImage{
    
    _originalImage = originalImage;
    
    UIImage * thumnailImage;
    
    if (self.originalImage) {  //有，就是用取到的图。
        thumnailImage = [self.originalImage aspectFill:CGSizeMake(80, CellHeight)];
    }
    for (FilterCell *cell in self.cellsArray) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *iconImage = [self filteredImage:thumnailImage withFilterName:cell.filterKey];
            [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:iconImage waitUntilDone:NO];
        });
    }
}

- (void)tappedFilterCell:(UITapGestureRecognizer*)sender
{
    FilterCell *view = (FilterCell *)sender.view;
    
    view.alpha = 0.2;
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 1;
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (self.displayImageView && self.originalImage) {
            UIImage *image = [self filteredImage:self.originalImage withFilterName:view.filterKey];
            [self.displayImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        }
    });
    
}


- (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterKey
{
    if([filterKey isEqualToString:@"Original"]){
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterKey keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    if([filterKey isEqualToString:@"CIVignetteEffect"]){  //图片的暗角滤镜效果，要设置中心点，半径，强度。
        // parameters for CIVignetteEffect
        CGFloat R = MIN(image.size.width, image.size.height)/2;
        CIVector *vct = [[CIVector alloc] initWithX:image.size.width/2 Y:image.size.height/2];
        [filter setValue:vct forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputIntensity"];
        [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    }
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
    
}

@end

