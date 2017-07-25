//
//  LoadingViewController.m
//  MJFLoadAnimatingDemo
//
//  Created by 巫龙 on 17/7/25.
//  Copyright © 2017年 巫龙. All rights reserved.
//

#import "LoadingViewController.h"
#import "MJFLoadingAnimationView.h"

@interface LoadingViewController ()
@property (strong, nonatomic) MJFLoadingAnimationView *mLoadView;

-(IBAction)clickBtn:(UIButton *)sender;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.mLoadView];
    
    __weak typeof(self) weakself = self;
    self.mLoadView.reloadButtonClickCompleted = ^(UIButton *sender) {
        // 这里可以做网络重新加载的地方
        [weakself reloadAnimotionClick];
    };
    
    [self.mLoadView showLoadingAnimatedWithStatus:LoadingAnimatingStatus_Loading showText:@"加载中..."];
}

-(MJFLoadingAnimationView *)mLoadView{
    if(_mLoadView == nil){
        _mLoadView = [[MJFLoadingAnimationView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
    }
    return _mLoadView;
}

- (void)reloadAnimotionClick
{
    
}

-(IBAction)clickBtn:(UIButton *)sender{

    if(sender.tag == 101){
        [self.mLoadView removeFromSuperview];
        [self.view addSubview:self.mLoadView];
        self.mLoadView.alpha = 1.0;
        [self.mLoadView showLoadingAnimatedWithStatus:LoadingAnimatingStatus_Loading showText:@"加载中..."];
    }else if (sender.tag == 102){
        [self.mLoadView removeFromSuperview];
        [self.view addSubview:self.mLoadView];
        self.mLoadView.alpha = 1.0;
        [self.mLoadView showLoadingAnimatedWithStatus:LoadingAnimatingStatus_reload showText:@""];
    }else{
        [self.mLoadView hideLoadingView];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
