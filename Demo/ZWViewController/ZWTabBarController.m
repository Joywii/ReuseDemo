//
//  SGTabBarController.m
//  sogoureader
//
//  Created by joywii on 13-8-26.
//  Copyright (c) 2013年 joywii. All rights reserved.
//

#import "ZWTabBarController.h"
#import "CameraViewController.h"

@interface ZWTabBarController()

@end

@implementation ZWTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    
    UIViewController *firstViewController = [[UIViewController alloc] init];
    firstViewController.view.backgroundColor = [UIColor orangeColor];
    firstViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"First" image:nil tag:1000];
    
    UIViewController *secondViewController = [[UIViewController alloc] init];
    secondViewController.view.backgroundColor = [UIColor magentaColor];
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:1001];
    
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    thirdViewController.view.backgroundColor = [UIColor purpleColor];
    thirdViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Third" image:nil tag:1002];
    
    UIViewController *fourthViewController = [[UIViewController alloc] init];
    fourthViewController.view.backgroundColor = [UIColor brownColor];
    fourthViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Fourth" image:nil tag:1003];
    
    UIViewController *blankViewController = [[UIViewController alloc] init];
    blankViewController.view.backgroundColor = [UIColor grayColor];

    self.viewControllers = @[firstViewController,secondViewController,blankViewController,thirdViewController,fourthViewController];

    [self addCenterButtonWithImage:[UIImage imageNamed:@"capture-button"] highlightImage:nil];
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    CGFloat backViewWidth = [[UIScreen mainScreen] bounds].size.width / [self.viewControllers count];
    CGFloat backViewHeight = self.tabBar.frame.size.height;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth + 4, backViewHeight)];
    backView.backgroundColor = [UIColor clearColor];
    backView.center = self.tabBar.center;
    [self.view addSubview:backView];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showCameaViewController) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
    {
        button.center = self.tabBar.center;
    }
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    [self.view addSubview:button];
}
- (void)showCameaViewController
{
    CameraViewController *cameraViewController = [[CameraViewController alloc] init];
    [self presentViewController:cameraViewController animated:NO completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
}
- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    //int index = [self.viewControllers indexOfObject:selectedViewController];
}
@end
