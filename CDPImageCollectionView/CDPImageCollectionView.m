//
//  CDPImageCollectionView.m
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPImageCollectionView.h"
#import "CDPImageCollectionViewCell.h"
@implementation CDPImageCollectionView {
    UICollectionView *_collectView;
    NSMutableArray *_imageUrlArr;//image数据源
    UIPageControl *_pageControl;//页面控制
    UICollectionViewScrollDirection _scrollDirection;//滚动方向
    NSTimer *_timer;//计时器
    BOOL _isTimerOpen;//判断是否打开计时器
    NSTimeInterval _duration;//时间间隔
    NSTimeInterval _changetime;//时间状态，若为0，则更新collectionView
}

//初始化
-(id)initWithFrame:(CGRect)frame andImageUrlArr:(NSArray *)imageUrlArr scrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    if (self=[super initWithFrame:frame]) {
        _isTimerOpen=NO;
        self.backgroundColor=[UIColor clearColor];
        self.frame=frame;
        _scrollDirection=scrollDirection;
        
        _imageUrlArr=[[NSMutableArray alloc] initWithArray:imageUrlArr];
        NSString *firstImageUrl=[_imageUrlArr objectAtIndex:0];
        NSString *lastImageUrl=[_imageUrlArr lastObject];
        [_imageUrlArr insertObject:lastImageUrl atIndex:0];
        [_imageUrlArr addObject:firstImageUrl];
        
        //collectionView设置
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:frame.size];
        layout.scrollDirection=scrollDirection;
        layout.minimumInteritemSpacing=0;
        layout.minimumLineSpacing=0;
        
        _collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height) collectionViewLayout:layout];
        _collectView.pagingEnabled=YES;
        _collectView.showsHorizontalScrollIndicator=NO;
        _collectView.showsVerticalScrollIndicator=NO;
        _collectView.backgroundColor=[UIColor clearColor];
        _collectView.bounces=NO;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        if (_scrollDirection==UICollectionViewScrollDirectionHorizontal) {
            _collectView.contentOffset=CGPointMake(frame.size.width,0);
        }
        else if(_scrollDirection==UICollectionViewScrollDirectionVertical){
            _collectView.contentOffset=CGPointMake(0,frame.size.height);
        }
        [_collectView registerClass:[CDPImageCollectionViewCell class] forCellWithReuseIdentifier:@"CDPImageCollectionViewCell"];
        [self addSubview:_collectView];
        
        //设置pageControl
        _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0,self.bounds.size.height-20,frame.size.width,0)];
        _pageControl.numberOfPages=_imageUrlArr.count-2;
        _pageControl.userInteractionEnabled=NO;
        if(_scrollDirection==UICollectionViewScrollDirectionVertical){
            _pageControl.transform=CGAffineTransformMakeRotation((90*M_PI)/180);
            _pageControl.frame=CGRectMake(0,0,20,self.bounds.size.height);
        }
        [self addSubview:_pageControl];
        
    }
    
    return self;
}

-(void)setPageControlHidden:(BOOL)pageControlHidden{
    _pageControl.hidden=pageControlHidden;
}

#pragma mark timer计时器相关操作
-(void)setTimerToPause:(BOOL)timerToPause{
    if (_isTimerOpen==YES) {
        if (timerToPause==YES) {
            [_timer setFireDate:[NSDate distantFuture]];
        }
        else{
            [_timer setFireDate:[NSDate distantPast]];
        }
    }
    else{
        NSLog(@"计时器之前没有打开");
    }
}
-(void)openTheTimerAndSetTheDuration:(NSTimeInterval)duration{
    if (_isTimerOpen==NO) {
        _duration=duration;
        _changetime=duration;
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCollectionView) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
        _isTimerOpen=YES;
    }
    else{
        NSLog(@"计时器之前已经打开");
    }
    
}
-(void)closeTheTimer{
    if (_isTimerOpen==YES) {
        [_timer invalidate];
        _isTimerOpen=NO;
    }
    else{
        NSLog(@"计时器之前没有打开");
    }
}
-(void)updateCollectionView{
    _changetime--;
    if (_changetime==0) {
        _changetime=_duration;
        if (_scrollDirection==UICollectionViewScrollDirectionHorizontal) {
            //横向滚动
            
            [UIView animateWithDuration:1 animations:^{
                _collectView.contentOffset=CGPointMake(_collectView.contentOffset.x+self.bounds.size.width,_collectView.contentOffset.y);
            } completion:^(BOOL finished) {
                if (_collectView.contentOffset.x>=_collectView.contentSize.width-self.bounds.size.width) {
                    _collectView.contentOffset=CGPointMake(self.bounds.size.width,_collectView.contentOffset.y);
                    _pageControl.currentPage=0;
                }
                else if (_collectView.contentOffset.x<self.bounds.size.width) {
                    _collectView.contentOffset=CGPointMake(_collectView.contentSize.width-(self.bounds.size.width*2),_collectView.contentOffset.y);
                    _pageControl.currentPage=_collectView.contentOffset.x/self.bounds.size.width-1;
                }
                else{
                    _pageControl.currentPage=_collectView.contentOffset.x/self.bounds.size.width-1;
                }
            }];
            
        }
        else if(_scrollDirection==UICollectionViewScrollDirectionVertical){
            //竖向滚动
            [UIView animateWithDuration:1 animations:^{
                _collectView.contentOffset=CGPointMake(_collectView.contentOffset.x,_collectView.contentOffset.y+self.bounds.size.height);
            } completion:^(BOOL finished) {
                if (_collectView.contentOffset.y>=_collectView.contentSize.height-self.bounds.size.height) {
                    _collectView.contentOffset=CGPointMake(_collectView.contentOffset.x,self.bounds.size.height);
                    _pageControl.currentPage=0;
                }
                else if (_collectView.contentOffset.y<self.bounds.size.height) {
                    _collectView.contentOffset=CGPointMake(_collectView.contentOffset.x,_collectView.contentSize.height-(self.bounds.size.height*2));
                    _pageControl.currentPage=_collectView.contentOffset.y/self.bounds.size.height-1;
                }
                else{
                    _pageControl.currentPage=_collectView.contentOffset.y/self.bounds.size.height-1;
                }
            }];
        }
    }
}
#pragma mark collectionViewDataSource
//组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//图片数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageUrlArr.count;
}
//进行cell设置
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CDPImageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CDPImageCollectionViewCell" forIndexPath:indexPath];
    [cell setImageViewUrl:[_imageUrlArr objectAtIndex:indexPath.row] andplaceholderImage:nil];
    
    return cell;
}
//点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectImageWithNumber:indexPath.row-1];
}

//结束减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _changetime=_duration;
    if (_scrollDirection==UICollectionViewScrollDirectionHorizontal) {
        //横向滚动
        if (scrollView.contentOffset.x>=scrollView.contentSize.width-self.bounds.size.width) {
            scrollView.contentOffset=CGPointMake(self.bounds.size.width,scrollView.contentOffset.y);
            _pageControl.currentPage=0;
        }
        else if (scrollView.contentOffset.x<self.bounds.size.width) {
            scrollView.contentOffset=CGPointMake(scrollView.contentSize.width-(self.bounds.size.width*2),scrollView.contentOffset.y);
            _pageControl.currentPage=scrollView.contentOffset.x/self.bounds.size.width-1;
        }
        else{
            _pageControl.currentPage=scrollView.contentOffset.x/self.bounds.size.width-1;
        }
    }
    else if(_scrollDirection==UICollectionViewScrollDirectionVertical){
        //竖向滚动
        if (scrollView.contentOffset.y>=scrollView.contentSize.height-self.bounds.size.height) {
            scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x,self.bounds.size.height);
            _pageControl.currentPage=0;
        }
        else if (scrollView.contentOffset.y<self.bounds.size.height) {
            scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x,scrollView.contentSize.height-(self.bounds.size.height*2));
            _pageControl.currentPage=scrollView.contentOffset.y/self.bounds.size.height-1;
        }
        else{
            _pageControl.currentPage=scrollView.contentOffset.y/self.bounds.size.height-1;
        }
    }
    
}



-(void)dealloc{
    if (_isTimerOpen==YES) {
        [_timer invalidate];
        _isTimerOpen=NO;
    }
    _collectView.delegate=nil;
    _collectView.dataSource=nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
