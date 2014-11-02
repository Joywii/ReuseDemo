//
//  ZWHomeViewController.m
//  Demo
//
//  Created by joywii on 14/11/2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWHomeViewController.h"
#import "HMSegmentedControl.h"

@interface ZWHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *findTableView;
@property (nonatomic,strong) UITableView *followTableView;
@property (nonatomic,strong) UITableView *cityTableView;
@property (nonatomic,strong) UIScrollView *pageScrollView;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;

@end

@implementation ZWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    topBackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topBackView];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"发现", @"关注", @"同城"]];
    self.segmentedControl.frame = CGRectMake(40, 20, kScreenWidth-80, 44);
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.textColor = [UIColor grayColor];
    self.segmentedControl.font = [UIFont systemFontOfSize:18];
    self.segmentedControl.selectedTextColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 3.0f;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:36.0/255.0 green:137.0/255.0 blue:167.0/255.0 alpha:1];

    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.pageScrollView.backgroundColor = [UIColor clearColor];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    self.pageScrollView.contentSize = CGSizeMake(kScreenWidth *3, kScreenHeight - kAjustHeight);
    [self.view addSubview:self.pageScrollView];
    
    self.findTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.findTableView.backgroundColor = [UIColor redColor];
    self.findTableView.delegate = self;
    self.findTableView.dataSource = self;
    [self.pageScrollView addSubview:self.findTableView];
    
    self.followTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.followTableView.backgroundColor = [UIColor greenColor];
    self.followTableView.delegate = self;
    self.followTableView.dataSource = self;
    [self.pageScrollView addSubview:self.followTableView];
    
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.cityTableView.backgroundColor = [UIColor blueColor];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    [self.pageScrollView addSubview:self.cityTableView];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.pageScrollView.contentOffset = CGPointMake((long)segmentedControl.selectedSegmentIndex * kScreenWidth, 0);
                     }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTagTableCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectTagTableCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = @"吐槽";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.pageScrollView)
    {
        int index = fabs(scrollView.contentOffset.x)/self.pageScrollView.frame.size.width;

        self.segmentedControl.selectedSegmentIndex = index;
    }
}
@end
