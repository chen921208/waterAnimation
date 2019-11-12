//
//  SPWaterView.h
//  WaterDemo
//
//  Created by 三皮 on 2019/11/12.
//  Copyright © 2019 三皮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPWaterView : UIView
/**
 
  设置扩散倍数。默认1.423倍
 
  */
@property (nonatomic, assign) CGFloat multiple;
- (instancetype)initWithFrame:(CGRect)frame;

@end

