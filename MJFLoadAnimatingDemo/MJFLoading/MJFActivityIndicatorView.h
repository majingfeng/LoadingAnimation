//
//  MJFActivityIndicatorView.h
//  MJFLoadAnimating
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJFActivityIndicatorView : UIView

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,readonly) BOOL isAnimating;
@property (nonatomic) BOOL hidesWhenStopped;

-(void) startAnimating;

-(void) stopAnimating;

@end
