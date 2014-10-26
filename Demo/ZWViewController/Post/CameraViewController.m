//
//  CameraViewController.m
//  ImageShare
//
//  Created by joywii on 14-9-1.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "CameraViewController.h"
#import "ZWDemoRequest.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 50, 300, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    ZWRequestCompletionBlock completionBlock = ^(ZWRequestState *state)
    {
        
    };
    ZWDemoRequest *request = [[ZWDemoRequest alloc] initGetWithURL:@"http://www.weather.com.cn/data/cityinfo/101010100.html"
                                                            params:nil
                                                  httpHeaderFields:nil
                                                          delegate:nil
                                                      requestBlock:completionBlock];
    [request startRequest];
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
