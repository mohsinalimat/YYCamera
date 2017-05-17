
//
//  YYRootViewController.m
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "YYRootViewController.h"
#import "YYCameraAndPhoto.h"
#import "config.h"
#import "YYCameraViewController.h"

@interface YYRootViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *operationBgView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (assign, nonatomic) BOOL front;
@property (strong, nonatomic) UIImagePickerController *pickerController;


@end

@implementation YYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleCamera];
    
    self.cameraButton.backgroundColor = [UIColor redColor];
    self.cameraButton.layer.cornerRadius = self.cameraButton.frame.size.width / 2;
    self.cameraButton.layer.borderWidth = 4;
    self.cameraButton.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)handleCamera
{
    CGFloat scale = kScreen_Height/kScreen_Width * 4/3;
    self.pickerController.cameraViewTransform = CGAffineTransformMakeScale(scale, scale);
    [self.view addSubview:self.pickerController.view];
    [self.view bringSubviewToFront:self.operationBgView];
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


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (!self.cameraButton.enabled) {  //用的是相机照相。
        self.cameraButton.enabled = YES;
    } else { //用的是相册
        [picker dismissViewControllerAnimated:NO completion:^() {
        }];
    }
    
    YYCameraViewController *cameraVC = [[YYCameraViewController alloc] initWithNibName:@"YYCameraViewController" bundle:nil];
    cameraVC.targetImage = portraitImg;
    [self.navigationController pushViewController:cameraVC animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
        [self handleCamera];
    }];
}

#pragma mark - xib click

- (IBAction)cameraBtnAction:(id)sender
{
    self.cameraButton.enabled = NO;
    [self.pickerController takePicture];
}

- (IBAction)libraryBtnAction:(id)sender
{
    UIImagePickerController *controller = [YYCameraAndPhoto getPhotoLibraryPickerController];
    if (controller) {
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"获取相册失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }

}

- (IBAction)exchangeBtnAction:(id)sender
{
    _front = !_front;
    if (_front) {
        self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    } else {
        self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

#pragma mark -  setter getter

- (UIImagePickerController *)pickerController
{
    if (_pickerController == nil) {
        _pickerController = [YYCameraAndPhoto getCameraPickerControllerIsFront:_front];
        _pickerController.delegate = self;
        _pickerController.showsCameraControls = NO;
        _pickerController.navigationBarHidden = YES;
    }
    
    return _pickerController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
