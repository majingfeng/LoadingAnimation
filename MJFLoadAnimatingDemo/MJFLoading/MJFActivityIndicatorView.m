//
//  MJFActivityIndicatorView.m
//  MJFLoadAnimating
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import "MJFActivityIndicatorView.h"

#define ANGLE(a) 2*M_PI/360*a

@interface MJFActivityIndicatorView ()
@property (nonatomic,assign) CGFloat anglePer;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *statusLabel;

@end

@implementation MJFActivityIndicatorView

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id) init{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) setAnglePer:(CGFloat)anglePer{
    _anglePer = anglePer;
    [self setNeedsDisplay];
}

-(void) startAnimating{
    if(self.isAnimating){
        [self stopAnimating];
        [self.layer removeAllAnimations];
    }
    _isAnimating = YES;
    if(_hidesWhenStopped){
        self.hidden = NO;
    }
    self.anglePer = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(drawPathAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void) stopAnimating{
    _isAnimating = NO;
    if([self.timer isValid]){
        [self.timer invalidate];
        self.timer = nil;
    }
    [self stopRotateAnimation];
}

-(void) drawPathAnimation:(NSTimer *)timer{
    self.anglePer+=0.03f;
    if(self.anglePer>=1){
        self.anglePer = 1;
        [timer invalidate];
        self.timer = nil;
        [self startRotateAnimation];
    }
}

-(void) startRotateAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.anglePer = 0;
        [self.layer removeAllAnimations];
        self.alpha = 1;
        if (_hidesWhenStopped) {
            self.hidden = YES;
        }
        
    }];
}

- (void)drawRect:(CGRect)rect
{
    if (self.anglePer <= 0) {
        _anglePer = 0;
    }
    
    CGFloat lineWidth = 1.f;
    UIColor *lineColor = [UIColor lightGrayColor];
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.borderColor) {
        lineColor = self.borderColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    ANGLE(120), ANGLE(120)+ANGLE(330)*self.anglePer,
                    0);
    CGContextStrokePath(context);
}

@end
