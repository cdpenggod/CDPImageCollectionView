//
//  CDPImageCollectionViewCell.h
//  imageCollectionView
//
//  Created by 柴东鹏 on 15/5/1.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDPImageCollectionViewCell : UICollectionViewCell
//设置imageView图片url及placeholderImage
-(void)setImageViewUrl:(NSString *)imageViewUrl andplaceholderImage:(UIImage *)placeholderImage;

@end
