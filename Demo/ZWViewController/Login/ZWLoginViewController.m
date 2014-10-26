//
//  ZWLoginViewController.m
//  Demo
//
//  Created by joywii on 14/10/26.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWLoginViewController.h"

@interface ZWLoginViewController ()

@end

@implementation ZWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"bg_login"];
    [self.view addSubview:backImageView];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 45, 150, 90, 120)];
    logoImageView.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImageView];
    
    CGFloat margin = (kScreenWidth - 3 * 55) / 4;
    CGFloat loginY = kScreenHeight - 50 - 80;
    
    UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake(margin, loginY,55, 80)];
    weixinButton.tag = 0;
    [weixinButton setImage:[UIImage imageNamed:@"login_weixin"]  forState:UIControlStateNormal];
    [weixinButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinButton];
    
    UIButton *qqButton = [[UIButton alloc] initWithFrame:CGRectMake(margin*2 + 55,loginY,55, 80)];
    qqButton.tag = 1;
    [qqButton setImage:[UIImage imageNamed:@"login_qq"]  forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqButton];
    
    UIButton *sinaButton = [[UIButton alloc] initWithFrame:CGRectMake(margin*3 + 55*2,loginY,55, 80)];
    sinaButton.tag = 2;
    [sinaButton setImage:[UIImage imageNamed:@"login_sina"]  forState:UIControlStateNormal];
    [sinaButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaButton];
}
- (void)login:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 0:
        {
            //微信登录
            break;
        }
        case 1:
        {
            //QQ登录
            break;
        }
        case 2:
        {
            //新浪登录
            break;
        }
        default:
            break;
    }
}
@end
