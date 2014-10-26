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

@property (nonatomic,strong) UIButton *homeButton;
@property (nonatomic,strong) UIButton *hallButton;
@property (nonatomic,strong) UIButton *camereButton;
@property (nonatomic,strong) UIButton *messageButton;
@property (nonatomic,strong) UIButton *myButton;

@end

@implementation ZWTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    
    UIViewController *firstViewController = [[UIViewController alloc] init];
    firstViewController.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *secondViewController = [[UIViewController alloc] init];
    secondViewController.view.backgroundColor = [UIColor magentaColor];
    
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    thirdViewController.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *fourthViewController = [[UIViewController alloc] init];
    fourthViewController.view.backgroundColor = [UIColor brownColor];
    
    //空白的
    UIViewController *blankViewController = [[UIViewController alloc] init];
    blankViewController.view.backgroundColor = [UIColor grayColor];

    self.viewControllers = @[firstViewController,secondViewController,blankViewController,thirdViewController,fourthViewController];

    /////////////////////////////////////////////////////////////////////////////////////////////
    UIView *backView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    backView.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
    [self.tabBar addSubview:backView];
    
    CGFloat buttonWidth = self.tabBar.bounds.size.width / [self.viewControllers count];
    CGFloat buttonHeight = self.tabBar.bounds.size.height;
    
    self.homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,buttonWidth, buttonHeight)];
    self.homeButton.tag = 0;
    self.homeButton.selected = YES;
    self.homeButton.backgroundColor = [UIColor colorWithHexString:@"1496b4"];
    [self.homeButton setImage:[UIImage imageNamed:@"ico_home_off"] forState:UIControlStateNormal];
    //[self.homeButton setImage:[UIImage imageNamed:@"ico_home_on"]  forState:UIControlStateHighlighted];
    [self.homeButton setImage:[UIImage imageNamed:@"ico_home_on"]  forState:UIControlStateSelected];
    [self.homeButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:self.homeButton];
    
    self.hallButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth , 0,buttonWidth, buttonHeight)];
    self.hallButton.tag = 1;
    [self.hallButton setImage:[UIImage imageNamed:@"ico_hall_off"]  forState:UIControlStateNormal];
    //[self.hallButton setImage:[UIImage imageNamed:@"ico_hall_on"]  forState:UIControlStateHighlighted];
    [self.hallButton setImage:[UIImage imageNamed:@"ico_hall_on"]  forState:UIControlStateSelected];
    [self.hallButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:self.hallButton];
    
    self.camereButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*2 , 0,buttonWidth, buttonHeight)];
    self.camereButton.tag = 2;
    self.camereButton.backgroundColor = [UIColor colorWithHexString:@"323232"];
    [self.camereButton setImage:[UIImage imageNamed:@"ico_cam"]  forState:UIControlStateNormal];
    [self.camereButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:self.camereButton];
    
    self.messageButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*3 , 0,buttonWidth, buttonHeight)];
    self.messageButton.tag = 3;
    [self.messageButton setImage:[UIImage imageNamed:@"ico_message_off"]  forState:UIControlStateNormal];
    //[self.messageButton setImage:[UIImage imageNamed:@"ico_message_on"]  forState:UIControlStateHighlighted];
    [self.messageButton setImage:[UIImage imageNamed:@"ico_message_on"]  forState:UIControlStateSelected];
    [self.messageButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:self.messageButton];
    
    self.myButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*4 , 0,buttonWidth, buttonHeight)];
    self.myButton.tag = 4;
    [self.myButton setImage:[UIImage imageNamed:@"ico_my_off"]  forState:UIControlStateNormal];
    //[self.myButton setImage:[UIImage imageNamed:@"ico_my_on"]  forState:UIControlStateHighlighted];
    [self.myButton setImage:[UIImage imageNamed:@"ico_my_on"]  forState:UIControlStateSelected];
    [self.myButton addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:self.myButton];
}
- (void)changePage:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 0:
        {
            self.selectedIndex = 0;
            self.homeButton.selected = YES;
            self.homeButton.backgroundColor = [UIColor colorWithHexString:@"1496b4"];
            self.hallButton.selected = NO;
            self.hallButton.backgroundColor = [UIColor clearColor];
            self.messageButton.selected = NO;
            self.messageButton.backgroundColor = [UIColor clearColor];
            self.myButton.selected = NO;
            self.myButton.backgroundColor = [UIColor clearColor];
            break;
        }
        case 1:
        {
            self.selectedIndex = 1;
            self.homeButton.selected = NO;
            self.homeButton.backgroundColor = [UIColor clearColor];
            self.hallButton.selected = YES;
            self.hallButton.backgroundColor = [UIColor colorWithHexString:@"1496b4"];
            self.messageButton.selected = NO;
            self.messageButton.backgroundColor = [UIColor clearColor];
            self.myButton.selected = NO;
            self.myButton.backgroundColor = [UIColor clearColor];
            break;
        }
        case 2:
        {
            CameraViewController *cameraViewController = [[CameraViewController alloc] init];
            [self presentViewController:cameraViewController animated:YES completion:nil];
            break;
        }
        case 3:
        {
            self.selectedIndex = 3;
            self.homeButton.selected = NO;
            self.homeButton.backgroundColor = [UIColor clearColor];
            self.hallButton.selected = NO;
            self.hallButton.backgroundColor = [UIColor clearColor];
            self.messageButton.selected = YES;
            self.messageButton.backgroundColor = [UIColor colorWithHexString:@"1496b4"];
            self.myButton.selected = NO;
            self.myButton.backgroundColor = [UIColor clearColor];
            break;
        }
        case 4:
        {
            self.selectedIndex = 4;
            self.homeButton.selected = NO;
            self.homeButton.backgroundColor = [UIColor clearColor];
            self.hallButton.selected = NO;
            self.hallButton.backgroundColor = [UIColor clearColor];
            self.messageButton.selected = NO;
            self.messageButton.backgroundColor = [UIColor clearColor];
            self.myButton.selected = YES;
            self.myButton.backgroundColor = [UIColor colorWithHexString:@"1496b4"];
            break;
        }
        default:
            break;
    }
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
//{
//    CGFloat backViewWidth = [[UIScreen mainScreen] bounds].size.width / [self.viewControllers count];
//    CGFloat backViewHeight = self.tabBar.frame.size.height;
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth + 4, backViewHeight)];
//    backView.backgroundColor = [UIColor clearColor];
//    backView.center = self.tabBar.center;
//    [self.view addSubview:backView];
//    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(showCameaViewController) forControlEvents:UIControlEventTouchUpInside];
//    
//    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//    if (heightDifference < 0)
//    {
//        button.center = self.tabBar.center;
//    }
//    else
//    {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0;
//        button.center = center;
//    }
//    [self.view addSubview:button];
//}
