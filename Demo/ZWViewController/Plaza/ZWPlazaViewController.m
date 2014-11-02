//
//  ZWPlazaViewController.m
//  Demo
//
//  Created by joywii on 14/11/2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWPlazaViewController.h"
#import "HMSegmentedControl.h"


@interface ZWPlazaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tiezhiTableView;
@property (nonatomic,strong) UITableView *sameCityTableView;
@property (nonatomic,strong) UITableView *moreTableView;
@property (nonatomic,strong) UIScrollView *pageScrollView;
@property (nonatomic,strong) HMSegmentedControl *segmentedControl;

@end

@implementation ZWPlazaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    topBackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topBackView];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"贴纸", @"同城", @"更多"]];
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
    
    self.tiezhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.tiezhiTableView.backgroundColor = [UIColor redColor];
    self.tiezhiTableView.delegate = self;
    self.tiezhiTableView.dataSource = self;
    [self.pageScrollView addSubview:self.tiezhiTableView];
    
    self.sameCityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.sameCityTableView.backgroundColor = [UIColor greenColor];
    self.sameCityTableView.delegate = self;
    self.sameCityTableView.dataSource = self;
    [self.pageScrollView addSubview:self.sameCityTableView];
    
    self.moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight - kAjustHeight)];
    self.moreTableView.backgroundColor = [UIColor blueColor];
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    [self.pageScrollView addSubview:self.moreTableView];
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
