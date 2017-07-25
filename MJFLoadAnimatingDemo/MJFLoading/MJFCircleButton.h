//
//  MJFCircleButton.h
//  MJFLoadAnimating
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJFCircleButton : UIButton

@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic) BOOL aniatedTap;
@property (nonatomic) BOOL displayShading;
@property (nonatomic) CGFloat borderSize;

-(void) blink;

-(void) setImage:(UIImage *)image animated:(BOOL) animated;

@end
