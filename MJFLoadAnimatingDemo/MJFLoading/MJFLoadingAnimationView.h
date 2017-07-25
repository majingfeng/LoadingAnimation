//
//  MJFLoadingAnimationView.h
//  MJFLoadAnimating
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoadingAnimatingStatus){
    LoadingAnimatingStatus_Loading = 0,
    LoadingAnimatingStatus_message,
    LoadingAnimatingStatus_reload
};

typedef void(^ReloadButtonClickedCompleted)(UIButton *sender);

@interface MJFLoadingAnimationView : UIView

@property (nonatomic,copy) ReloadButtonClickedCompleted reloadButtonClickCompleted;
@property (nonatomic,copy) NSString *reloadButtonImage_N;
@property (nonatomic,copy) NSString *reloadBottonImage_H;

-(void) showLoadingAnimatedWithStatus:(LoadingAnimatingStatus) status showText:(NSString *)text;


/**
 隐藏页面加载动画及信息提示
 */
-(void) hideLoadingView;

@end
