//
//  SPWaterView.m
//  WaterDemo
//
//  Created by 三皮 on 2019/11/12.
//  Copyright © 2019 三皮. All rights reserved.
//

#import "SPWaterView.h"
#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation SPWaterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _multiple = 1.423;
        
        [UIView animateWithDuration:4 animations:^{
            
            self.transform = CGAffineTransformScale(self.transform, 1.5, 1.5);
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    CALayer *animationLayer = [CALayer layer];
    
    //这里同时创建[缩放动画/背景色渐变/边框色渐变]三个简单动画
    NSArray *animationArray = [self animationArray];
    
    //将三个动画合并为n一个动画组
    CAAnimationGroup *animationGroup = [self animationGroupAnimations:animationArray];
    
    //添加动画组
    CALayer *pulsingLayer = [self pulsingLayer:rect animation:animationGroup];
    
    //将动画 Layer添加到 animationLayer
    [animationLayer addSublayer:pulsingLayer];
    
    //加入动画
    [self.layer addSublayer:animationLayer];
    
}

- (NSArray *)animationArray {
    NSArray *animationArray = nil;
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CAKeyframeAnimation *borderColorAnimation = [self backgroundColorAnimation];
    CAKeyframeAnimation *backGroundColorAnimation = [self backgroundColorAnimation];
    animationArray = @[scaleAnimation, backGroundColorAnimation, borderColorAnimation];
    return animationArray;
}


- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 3;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(_multiple);
    return scaleAnimation;
}

// 使用关键帧动画，使得颜色动画不要那么的线性变化
- (CAKeyframeAnimation *)backgroundColorAnimation {
    CAKeyframeAnimation *backgroundColorAnimation = [CAKeyframeAnimation animation];
    backgroundColorAnimation.keyPath = @"backgroundColor";
    backgroundColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
    backgroundColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return backgroundColorAnimation;
}

- (CAKeyframeAnimation *)borderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,(__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}


- (CALayer *)pulsingLayer:(CGRect)rect animation:(CAAnimationGroup *)animation {
    CALayer *pulsingLayer = [CALayer layer];
    pulsingLayer.borderWidth = 0.5;
    pulsingLayer.borderColor = ColorWithAlpha(255, 216, 87, 0.5).CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animation forKey:@"plulsing"];
    return pulsingLayer;
}

@end
