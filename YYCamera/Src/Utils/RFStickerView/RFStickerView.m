
//
//  RFStickerView.m
//  tujiao
//
//  Created by Saborka on 2/11/2016.
//  Copyright © 2016 Saborka. All rights reserved.
//  github: https://github.com/sensejump/YYCamera

#import "RFStickerView.h"
#import "BorderView.h"
#import "config.h"
#import "UIView+RFSize.h"

#define MinScale            0.3f
#define DefaultMinWidth     48.0f

@interface RFStickerView () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *controlImageView;
@property (strong, nonatomic) IBOutlet UIButton *turnBtn;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;

@property (assign, nonatomic) CGPoint touchStart;
@property (assign, nonatomic) float lastRotate;
@property (strong, nonatomic) BorderView *borderView;

@property (assign, nonatomic) float deltaAngle;
@property (assign, nonatomic) float minWidth;
@property (assign, nonatomic) float minHeight;
@property (assign, nonatomic) CGPoint prevPoint;

@end

@implementation RFStickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(StickerOperationInsertRectOffset, StickerOperationInsertRectOffset, self.width-2*StickerOperationInsertRectOffset, self.height-2*StickerOperationInsertRectOffset)];
    self.contentImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.contentImageView];
    
    //rotate
    UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
    [self addGestureRecognizer:rotateGes];
    
    //tap
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getFocus:)];
    tapGes.numberOfTapsRequired = 1;
    tapGes.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGes];
    
    [self drawCustomView];
    
    self.closeBtn.layer.cornerRadius = self.closeBtn.width / 2;
    self.closeBtn.backgroundColor = [UIColor darkGrayColor];
    self.closeBtn.layer.borderWidth = 1;
    self.closeBtn.layer.borderColor = RGB(26, 152, 167).CGColor;
    
    self.controlImageView.layer.cornerRadius = self.controlImageView.width / 2;
    self.controlImageView.layer.borderWidth = 1;
    self.controlImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.turnBtn.layer.cornerRadius = self.turnBtn.width / 2;
    self.turnBtn.layer.borderWidth = 1;
    self.turnBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)drawCustomView {
    if (DefaultMinWidth > self.bounds.size.width * MinScale) {  //如果缩放的最小倍数乘以宽度比48大，那就取前者，否则取48，反正最小不能小于48；
        self.minWidth = DefaultMinWidth;
        self.minHeight = self.bounds.size.height * (DefaultMinWidth/self.bounds.size.width);
    } else {
        self.minWidth = self.bounds.size.width * MinScale;
        self.minHeight = self.bounds.size.height * MinScale;
    }
    
    self.borderView = [[BorderView alloc] initWithFrame:CGRectMake(StickerOperationInsertRectOffset, StickerOperationInsertRectOffset, self.bounds.size.width-2*StickerOperationInsertRectOffset, self.bounds.size.height-2*StickerOperationInsertRectOffset) andColor:RGB(39, 129, 171) andInsertOffset:StickerOperationInsertRectOffset];
    [self addSubview:self.borderView];
    
    [[NSBundle mainBundle] loadNibNamed:@"RFStickerView" owner:self options:nil];
    
    //controllImageView
    self.controlImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [self.controlImageView addGestureRecognizer:panResizeGesture];
    self.deltaAngle = atan2(self.top+self.height - self.center.y,self.left+self.width - self.center.x);
    
    self.turnBtn.left = 0;
    self.turnBtn.top = 0;
    self.closeBtn.left = self.bounds.size.width-2*StickerOperationInsertRectOffset;
    self.closeBtn.top = 0;
    self.controlImageView.left = self.bounds.size.width-2*StickerOperationInsertRectOffset;
    self.controlImageView.top = self.bounds.size.height-2*StickerOperationInsertRectOffset;
    
    [self addSubview:self.turnBtn];
    [self addSubview:self.closeBtn];
    [self addSubview:self.controlImageView];
    
    [self displayCustomView:YES];

}

-(void)displayCustomView:(BOOL)isDisplay{
    self.borderView.hidden = !isDisplay;
    self.turnBtn.hidden = self.borderView.hidden;
    self.closeBtn.hidden = self.borderView.hidden;
    self.controlImageView.hidden = self.borderView.hidden;
}

- (IBAction)closeBtnClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)turnBtnClick:(id)sender {
    CGAffineTransform currentTransform = self.contentImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, -1, 1);
    [UIView animateWithDuration:0.2 animations:^{
        [self.contentImageView setTransform:newTransform];
    } completion:^(BOOL finished) {
    }];

}

- (void)rotateImage:(UIRotationGestureRecognizer*)ges {
    if (ges.state == UIGestureRecognizerStateBegan) {
        [self displayCustomView:YES];
    }
    
    if(ges.state == UIGestureRecognizerStateEnded) {
        self.lastRotate = 0.0;
        return;
    }
    
    CGFloat rotation = -self.lastRotate + ges.rotation;
    
    CGAffineTransform currentTransform = self.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [self setTransform:newTransform];
    
    self.lastRotate = ges.rotation;
}

- (void)getFocus:(UITapGestureRecognizer*)tapGes {
    [self displayCustomView:YES];
    
    for (UIView *view in self.superview.subviews) {  //让其他一样是这个类的视图都隐藏工具
        if ([view isKindOfClass:[self class]] && view != self ) {
            RFStickerView *temp =(RFStickerView *)view;
            [temp displayCustomView:NO];
        }
    }

}

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state]== UIGestureRecognizerStateBegan){
        self.prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged){
        if (self.bounds.size.width < self.minWidth || self.bounds.size.height < self.minHeight){
            
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.minWidth, self.minHeight);
            
            self.controlImageView.left = self.bounds.size.width-2*StickerOperationInsertRectOffset;
            self.controlImageView.top = self.bounds.size.height-2*StickerOperationInsertRectOffset;
            self.closeBtn.left = self.controlImageView.left;
            self.prevPoint = [recognizer locationInView:self];
            
        } else {
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            
            wChange = (point.x - self.prevPoint.x);
            hChange = (point.y - self.prevPoint.y);
            
            if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                self.prevPoint = [recognizer locationInView:self];
                return;
            }
            
            if (wChange < 0.0f && hChange < 0.0f) {
                float change = MIN(wChange, hChange);
                wChange = change;
                hChange = change;
            }
            if (wChange < 0.0f) {
                hChange = wChange;
            } else if (hChange < 0.0f) {
                wChange = hChange;
            } else {
                float change = MAX(wChange, hChange);
                wChange = change;
                hChange = change;
            }
            
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,self.bounds.size.width + (wChange),self.bounds.size.height + (hChange));
            self.controlImageView.left = self.bounds.size.width-2*StickerOperationInsertRectOffset;
            self.controlImageView.top = self.bounds.size.height-2*StickerOperationInsertRectOffset;
            self.closeBtn.left = self.controlImageView.left;
            self.prevPoint = [recognizer locationInView:self];
        }
        
        self.borderView.frame = CGRectMake(StickerOperationInsertRectOffset, StickerOperationInsertRectOffset, self.bounds.size.width-2*StickerOperationInsertRectOffset, self.bounds.size.height-2*StickerOperationInsertRectOffset);
        [self.borderView setNeedsDisplay];
        
        /* Rotation */
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y, [recognizer locationInView:self.superview].x - self.center.x);
        float angleDiff = self.deltaAngle - ang;
        self.transform = CGAffineTransformMakeRotation(-angleDiff);
        
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        self.prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
}

#pragma mark - touch
//move
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.touchStart = [touch locationInView:self.superview];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    [self translateUsingTouchLocation:touch];
    self.touchStart = touch;
}

- (void)translateUsingTouchLocation:(CGPoint)touchPoint {
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - self.touchStart.x,
                                    self.center.y + touchPoint.y - self.touchStart.y);
    
    //限制边界
            CGFloat midPointX = CGRectGetMidX(self.bounds);
            if (newCenter.x > self.superview.bounds.size.width - midPointX) {
                newCenter.x = self.superview.bounds.size.width - midPointX;
            }
            if (newCenter.x < midPointX) {
                newCenter.x = midPointX;
            }
            CGFloat midPointY = CGRectGetMidY(self.bounds);
            if (newCenter.y > self.superview.bounds.size.height - midPointY) {
                newCenter.y = self.superview.bounds.size.height - midPointY;
            }
            if (newCenter.y < midPointY) {
                newCenter.y = midPointY;
            }
    
    self.center = newCenter;
}



@end
