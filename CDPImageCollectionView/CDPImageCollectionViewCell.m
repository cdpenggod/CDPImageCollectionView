//
//  CDPImageCollectionViewCell.m
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CDPImageCollectionViewCell{
    UIImageView *_imageView;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView *imageView=[[UIImageView alloc]init];
        [self addSubview:imageView];
        _imageView=imageView;
        _imageView.frame=self.bounds;
        self.backgroundColor=[UIColor clearColor];
    }
    
    return self;
}

-(void)setImageViewUrl:(NSString *)imageViewUrl andplaceholderImage:(UIImage *)placeholderImage{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageViewUrl] placeholderImage:placeholderImage];
}

@end
