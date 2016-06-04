//
//  ViewController.m
//  InfiniteRoll
//
//  Created by Mia on 16/6/4.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InfiniteRollScrollView *scrollView = [[InfiniteRollScrollView alloc] init];
    scrollView.frame = CGRectMake(30, 50, 300, 130);
    scrollView.delegate = self;
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    //需要显示的所有图片
    scrollView.imageArray = @[
                          [UIImage imageNamed:@"0"],
                          [UIImage imageNamed:@"1"],
                          [UIImage imageNamed:@"2"],
                          [UIImage imageNamed:@"3"],
                          [UIImage imageNamed:@"4"]
                          ];
    
    //需要显示的所有图片对应的信息
    scrollView.imageModelInfoArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        ImageModel *mode = [[ImageModel alloc]init];
        mode.name = [NSString stringWithFormat:@"picture-%zd",i];
        mode.url = [NSString stringWithFormat:@"http://www.baidu.com-%zd",i];
        [scrollView.imageModelInfoArray addObject:mode];
    }
    
    [self.view addSubview:scrollView];
}

-(void)infiniteRollScrollView:(InfiniteRollScrollView *)scrollView tapImageViewInfo:(id)info{
    ImageModel *model = (ImageModel *)info;
    NSLog(@"name:%@---url:%@", model.name, model.url);
}
@end
