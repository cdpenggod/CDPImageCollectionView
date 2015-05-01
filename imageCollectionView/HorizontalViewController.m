//
//  HorizontalViewController.m
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "HorizontalViewController.h"
#import "CDPImageCollectionView.h"
@interface HorizontalViewController () <CDPImageCollectionViewDelegate>//代理

@end

@implementation HorizontalViewController{
    UILabel *_label;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //将所需图片url集合成一个数组
    NSArray *imageArr=[NSArray arrayWithObjects:
                       @"http://wenwen.sogou.com/p/20100718/20100718135522-650851011.jpg",
                       @"http://img2.3lian.com/2014/f2/123/d/62.jpg",
                       @"http://d.hiphotos.baidu.com/zhidao/pic/item/562c11dfa9ec8a13e028c4c0f603918fa0ecc0e4.jpg",
                       @"http://img4q.duitang.com/uploads/item/201503/02/20150302165008_HPttF.thumb.700_0.png",
                       @"http://e.hiphotos.baidu.com/exp/w=500/sign=f03fa87b39292df597c3ac158c305ce2/7e3e6709c93d70cf5f16c759fbdcd100bba12bf1.jpg",
                       nil];
    //传入所需参数，最后一个参数为collectionView滚动方向
    //imageCollectionView为横向滚动
    CDPImageCollectionView *imageCollectionView=[[CDPImageCollectionView alloc] initWithFrame:CGRectMake(0,100,self.view.bounds.size.width,120) andImageUrlArr:imageArr scrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //代理方法获得点击第几张图片,如不需要可不设置
    imageCollectionView.delegate=self;
    
    //计时器
    //[imageCollectionView openTheTimerAndSetTheDuration:3];
    [self.view addSubview:imageCollectionView];
    
    _label=[[UILabel alloc] initWithFrame:CGRectMake(80,270,200,40)];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_label];

    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0,20,30,30)];
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark CDPImageCollectionViewDelegate
-(void)didSelectImageWithNumber:(NSInteger)number{
    _label.text=[NSString stringWithFormat:@"点击了第%d张图片",number];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
