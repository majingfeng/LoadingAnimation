//
//  MJFLoadingAnimationView.m
//  MJFLoadAnimating
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import "MJFLoadingAnimationView.h"
#import "MJFCircleButton.h"
#import "MJFActivityIndicatorView.h"

#define MJFLoadingAnimatingContentPadding 8.f

@interface MJFLoadingAnimationView ()
@property (nonatomic,strong) MJFActivityIndicatorView *activityIndiactorView;
@property (nonatomic,strong) UILabel *loadingLabel;
@property (nonatomic,strong) MJFCircleButton *reloadButton;

@property (nonatomic,strong) UIView *contentView;

@end

@implementation MJFLoadingAnimationView

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor lightGrayColor];
        self.hidden = YES;
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

-(UIView *)contentView{
    if(_contentView == nil){
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.clipsToBounds = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(UILabel *) loadingLabel{
    if(_loadingLabel == nil){
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.textColor = [UIColor grayColor];
        _loadingLabel.font = [UIFont systemFontOfSize:15.0];
        _loadingLabel.alpha = 0.f;
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_loadingLabel];
    }
    return _loadingLabel;
}

- (UIButton *)reloadButton
{
    if (_reloadButton == nil) {
        _reloadButton = [[MJFCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90,90)];
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadButton.backgroundColor = [UIColor redColor];
        
        _reloadButton.alpha = 0.f;
        
        [self.contentView addSubview:_reloadButton];
    }
    
    return _reloadButton;
}

- (MJFActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndiactorView == nil) {
        _activityIndiactorView = [[MJFActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        _activityIndiactorView.alpha = 0.f;
        _activityIndiactorView.borderColor = [UIColor redColor];
        _activityIndiactorView.backgroundColor = [UIColor clearColor];
        _activityIndiactorView.lineWidth = 2.0;
        _activityIndiactorView.hidesWhenStopped = YES;
        [self.contentView addSubview:_activityIndiactorView];
    }
    
    return _activityIndiactorView;
}

- (void)reloadButtonClicked:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    if (self.reloadButtonClickCompleted) {
        self.reloadButtonClickCompleted(weakSelf.reloadButton);
    }
}

- (void)dealloc {
    self.reloadButtonClickCompleted = nil;
    
    [self stopActivityIndicatorView];
    self.activityIndiactorView = nil;
    self.loadingLabel = nil;
    self.reloadButton = nil;
}

- (void)stopActivityIndicatorView {
    if ([self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)setupAllUIWithAlpha {
    self.loadingLabel.alpha = 0.f;
    self.reloadButton.alpha = 0.f;
    self.activityIndicatorView.alpha = 0.f;
}

- (void)showLoadingAnimatedWithStatus:(LoadingAnimatingStatus)status showText:(NSString *)text
{
    [self setupAllUIWithAlpha];
    
    self.hidden = NO;
    self.loadingLabel.text = text;
    
    [self updateLayoutFrames:status];
    
    if (status == LoadingAnimatingStatus_Loading) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.reloadButton.alpha = 0.;
            self.loadingLabel.alpha = 1.;
            self.activityIndicatorView.alpha = 1.;
        } completion:^(BOOL finished) {
            
        }];
    }else if (status == LoadingAnimatingStatus_message)
    {
        [self stopActivityIndicatorView];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.activityIndicatorView.alpha = 0.;
            self.reloadButton.alpha = 0.;
            self.loadingLabel.alpha = 1.;
        } completion:^(BOOL finished) {
            
        }];
    }else
    {
        [self stopActivityIndicatorView];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.activityIndicatorView.alpha = 0.;
            self.reloadButton.alpha = 1.;
            self.loadingLabel.alpha = 1.;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)updateLayoutFrames:(LoadingAnimatingStatus)status
{
    CGRect activityFrame = CGRectZero;
    
    if (status == LoadingAnimatingStatus_Loading) {
        activityFrame = self.activityIndicatorView.frame;
        
        activityFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(activityFrame))/2;
        
        CGRect loadingLabelFrame = self.loadingLabel.frame;
        loadingLabelFrame.origin.x = 0;
        loadingLabelFrame.origin.y = CGRectGetHeight(activityFrame) + 8;
        loadingLabelFrame.size.width = CGRectGetWidth(self.bounds);
        loadingLabelFrame.size.height = 18;
        
        CGRect finalContentFrame = CGRectUnion(CGRectZero, loadingLabelFrame);
        finalContentFrame.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(finalContentFrame))*(1-0.618);
        finalContentFrame.origin.x = 0;
        
        [self.activityIndicatorView startAnimating];
        self.activityIndicatorView.frame = activityFrame;
        self.loadingLabel.frame = loadingLabelFrame;
        self.contentView.frame = finalContentFrame;
        
        return;
    }else if (status == LoadingAnimatingStatus_message)
    {
        activityFrame = self.reloadButton.frame;
    }else
    {
        activityFrame = self.reloadButton.frame;
    }
    activityFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(activityFrame))/2;
    
    CGRect loadingLabelFrame = self.loadingLabel.frame;
    loadingLabelFrame.origin.x = 0;
    loadingLabelFrame.origin.y = CGRectGetHeight(activityFrame) + 8;
    loadingLabelFrame.size.width = CGRectGetWidth(self.bounds);
    loadingLabelFrame.size.height = 18;
    
    CGRect finalContentFrame = CGRectUnion(CGRectZero, loadingLabelFrame);
    finalContentFrame.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(finalContentFrame))*(1-0.618);
    finalContentFrame.origin.x = 0;
    
    self.loadingLabel.frame = loadingLabelFrame;
    self.contentView.frame = finalContentFrame;
    self.reloadButton.frame = activityFrame;
}

/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
