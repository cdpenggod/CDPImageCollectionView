//
//  ViewController.m
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalViewController.h"
#import "VerticalViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake(110,100,100,40)];
    button1.backgroundColor=[UIColor whiteColor];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setTitle:@"横向滚动" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(horizontalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake(110,200,100,40)];
    button2.backgroundColor=[UIColor whiteColor];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitle:@"竖向滚动" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(verticalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10,250,self.view.bounds.size.width-20,self.view.bounds.size.height-260)];
    label.font=[UIFont boldSystemFontOfSize:17];
    label.backgroundColor=[UIColor whiteColor];
    label.numberOfLines=0;
    label.text=@"CDPImageCollectionView封装实现UICollectionView图片无限轮播,cell复用不浪费内存\n\n滚动方向分为横向和竖向,内置计时器及pageControl页面控制,可自行开启关闭(计时器默认关闭,pageControl默认开启),具体使用看demo\n\n(需要用到SDWebImage进行网络图片下载,如工程已有SDWebImage,可将本SDWebImage去掉)";
    [self.view addSubview:label];
}

-(void)horizontalClick{
    HorizontalViewController *viewController=[[HorizontalViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)verticalClick{
    VerticalViewController *viewController=[[VerticalViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
