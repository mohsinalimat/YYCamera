
//
//  YYCameraViewController.m
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "YYCameraViewController.h"
#import "FilterScrollView.h"
#import "RFStickerView.h"
#import "config.h"
#import "YYCameraAndPhoto.h"
#import "NextViewController.h"

static NSString *const stickerIdentifier = @"StickerIdentifier";

@interface YYCameraViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

//贴纸和表情等显示的舞台
@property (weak, nonatomic) IBOutlet UIView *stickTipsDisplayView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *targetImageView;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UIButton *stickerButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet FilterScollView *filterScrollView;

@property (strong, nonatomic) NSArray *filerArray;
@property (strong, nonatomic) NSArray *stickerArray;


@end

@implementation YYCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"照片处理";
    self.targetImageView.image = self.targetImage;
    self.stickerArray = @[@"elephant", @"cat", @"clothes", @"bag",
                          @"apple", @"fruit", @"dress", @"smile"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"StickerCell" bundle:nil] forCellWithReuseIdentifier:stickerIdentifier];
    self.filterButton.selected = YES;
    [self configOperationButton];
    self.filerArray = @[@"Original", @"CIPhotoEffectMono",@"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade", @"CIPhotoEffectInstant", @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess", @"CIPhotoEffectTonal", @"CIPhotoEffectTransfer",
                        @"CISRGBToneCurveToLinear", @"CIVignetteEffect"];
    [self.filterScrollView setUpWithOriginalImage:self.targetImage displayImageView:self.targetImageView andFilterArray:self.filerArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)configOperationButton
{
    self.filterScrollView.hidden = !self.filterButton.selected;
    self.collectionView.hidden = !self.stickerButton.selected;
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.stickerArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:stickerIdentifier forIndexPath:indexPath];
    UIImageView *sticker = (UIImageView *)[cell viewWithTag:100];
    sticker.image = [UIImage imageNamed:[self.stickerArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = [self.stickerArray objectAtIndex:indexPath.row];
    [self createStickerViewWithImage:imageName];
}

- (void)createStickerViewWithImage:(NSString *)imageName
{
    RFStickerView *stickView = [[RFStickerView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    stickView.backgroundColor = [UIColor clearColor];
    stickView.contentImageView.image = [UIImage imageNamed:imageName];
    [self.stickTipsDisplayView addSubview:stickView];
    [self.stickTipsDisplayView sendSubviewToBack:stickView];
}

-(void)hideAllStickViewCustomView{
    [self.stickTipsDisplayView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[RFStickerView class]]) {
            RFStickerView *temp = (RFStickerView *)obj;
            [temp displayCustomView:NO];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideAllStickViewCustomView];
}

#pragma mark - xib click

- (IBAction)filterBtnAction:(UIButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        self.stickerButton.selected = NO;
    }
    [self configOperationButton];
}

- (IBAction)stickerBtnAction:(UIButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        self.filterButton.selected = NO;
    }
    [self configOperationButton];
}

- (IBAction)nextBtnAction:(id)sender
{
    [self hideAllStickViewCustomView];
    self.bottomView.hidden = YES;
    UIImage *saveImage = [YYCameraAndPhoto getScreenShotWithView:self.view isFullSize:NO];
    saveImage = [YYCameraAndPhoto getImageFromImage:saveImage subImageSize:self.targetImageView.frame.size subImageRect:CGRectMake(self.targetImageView.frame.origin.x * 2 , self.targetImageView.frame.origin.y * 2 , self.targetImageView.frame.size.width * 2 , self.targetImageView.frame.size.height * 2 )];
    NextViewController *next = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil];
    next.image = saveImage;
    [self.navigationController pushViewController:next animated:YES];
    
}

- (IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
