//
//  ZWLoginViewController.m
//  Demo
//
//  Created by joywii on 14/10/26.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWLoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>


@interface ZWLoginViewController ()<TencentSessionDelegate>

@property (nonatomic,strong) TencentOAuth *tencentOAuth;


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
    
    //QQ登录
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTecentAppID andDelegate:self];
}
- (void)loginWithQQ
{
    NSArray *permission =   [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [self.tencentOAuth authorize:permission inSafari:NO];
}
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin
{
    // 登录成功
    
    if (self.tencentOAuth.accessToken && 0 != [self.tencentOAuth.accessToken length])
    {
        [self.tencentOAuth getUserInfo];
    }
    else
    {
        //获取Token失败
    }
}


/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        //用户取消登录
    }
    else
    {
        //登录失败
    }
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
}

/**
 * Called when the logout.
 */
-(void)tencentDidLogout
{
}
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse)
        {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        NSLog(@"%@",str);
    }
    else
    {
    }
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
            [self loginWithQQ];
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
