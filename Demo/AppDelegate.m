//
//  AppDelegate.m
//  Demo
//
//  Created by joywii on 14-9-2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWTabBarController.h"
#import "ZWLoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //微博登录
    [WeiboSDK enableDebugMode:YES];
    
    BOOL success = [WeiboSDK registerApp:kWeiboAppID];
    if (success )
    {
        NSLog(@"weibo login success");
    }
    else
    {
        NSLog(@"weibo login failed");
    }
    
    //监听登录通知
    [self addNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ZWTabBarController *tabbarController = [[ZWTabBarController alloc] init];
    self.window.rootViewController = tabbarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //是否登录
    if(![self isLogin])
    {
        //发送需要登录通知
        //[[NSNotificationCenter defaultCenter] postNotificationName:kNeedLoginNofitication object:nil userInfo:nil] ;
    }
    else
    {
        //发送已经登录通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidLoginNotification
                                                            object:nil
                                                          userInfo:nil] ;
    }
    //添加引导页
    
    return YES;
}
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLoginView:)
                                                 name:kNeedLoginNofitication
                                               object:nil];
}

-(BOOL)isLogin
{
    return NO;
}

-(void)showLoginView:(NSNotification *)notification
{
    ZWLoginViewController *loginVC = [[ZWLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];

    dispatch_async(dispatch_get_main_queue(), ^(void)
    {
        [self.window.rootViewController presentViewController:nav animated:NO completion:NULL];
    });
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url] | [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url] | [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        NSString *wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        NSLog(@"%@",wbtoken);
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:wbtoken,@"weiboToken", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kWeiboLoginNotification object:nil userInfo:userInfo];

        [alert show];
    }
}
@end
