//
//  CDPImageCollectionView.h
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

//CDPImageCollectionView需要SDWebImage配合使用
#import <UIKit/UIKit.h>

@protocol CDPImageCollectionViewDelegate <NSObject>

//获取点击图片的位置
-(void)didSelectImageWithNumber:(NSInteger)number;

@end

@interface CDPImageCollectionView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

//页面控制是否可见(默认可见)
@property (nonatomic,assign) BOOL pageControlHidden;

//计时器是否暂停(YES为暂停,NO为结束暂停,继续计时)
@property (nonatomic,assign) BOOL timerToPause;

//CDPImageCollectionViewDelegate代理
@property (nonatomic,assign) id <CDPImageCollectionViewDelegate> delegate;

//开启计时器并设置图片切换时间间隔
-(void)openTheTimerAndSetTheDuration:(NSTimeInterval)duration;

//关闭计时器
-(void)closeTheTimer;

//初始化
-(id)initWithFrame:(CGRect)frame andImageUrlArr:(NSArray *)imageUrlArr scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@end
