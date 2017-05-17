//
//  NextViewController.m
//  YYCamera
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "NextViewController.h"

@interface NextViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
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

- (IBAction)saveBtnAction:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"成功保存到相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
