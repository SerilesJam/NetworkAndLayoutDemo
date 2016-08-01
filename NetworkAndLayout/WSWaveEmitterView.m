//
//  WSWaveEmitterView.m
//  NetworkAndLayout
//
//  Created by 贾淼 on 16/8/1.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "WSWaveEmitterView.h"

#define maxmumCount 200

@interface WSWaveEmitterView ()

@property (nonatomic, assign) NSInteger amplitudeRange;
@property (nonatomic, assign) NSInteger amplitude;

@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval durationRange;

@property (nonatomic, assign) NSInteger currentCount;

@property (nonatomic, strong) NSMutableArray *unusedLayers;

@end

@implementation WSWaveEmitterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.amplitudeRange = 3;
    self.amplitude = 12;
    
    self.duration = 4;
    self.durationRange = 1;
    
    self.currentCount = 0;
    
}

#pragma mark public method

- (void)emitImage:(UIImage *)image {
    if (self.currentCount >= maxmumCount) {
        return ;
    }
    
    self.currentCount += 1;
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat percent = (arc4random()%100)/100;
    CFTimeInterval duration = self.duration + percent*self.durationRange*2 - self.durationRange;
    
    CALayer *layer;
    
    if (self.unusedLayers.count > 0) {
        layer = self.unusedLayers.lastObject;
        [self.unusedLayers removeLastObject];
    } else {
        layer = [CALayer layer];
    }
    
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    layer.opacity = 1;
    layer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    layer.position = CGPointMake(CGRectGetMidX(self.bounds), height);
    [self.layer addSublayer:layer];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [layer removeFromSuperlayer];
        [self.unusedLayers addObject:layer];
        self.currentCount -= 1;
    }];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    position.path = [self getPathInRect:self.bounds].CGPath;
    position.duration = self.duration;
    [layer addAnimation:position forKey:@"position"];
    
    CFTimeInterval delay = duration/2.0f;
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @1;
    opacity.toValue = @0;
    opacity.beginTime = CACurrentMediaTime() + delay;
    opacity.removedOnCompletion = false;
    opacity.fillMode = kCAFillModeForwards;
    opacity.duration = duration - delay - 0.1;
    [layer addAnimation:opacity forKey:@"opacity"];
    
    [CATransaction commit];
}

#pragma mark private method

- (UIBezierPath *)getPathInRect:(CGRect)rect {
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat offset = arc4random()%1000;
    CGFloat finalAmplitude = _amplitude + arc4random() % _amplitudeRange * 2 - _amplitudeRange;
    CGFloat delta = 0;
    
    CGFloat y = height;
    
    while (y >= 0) {
        CGFloat x = finalAmplitude * sinf((y+offset) * M_PI/180);
        if (y == height) {
            [path moveToPoint:CGPointMake(centerX, y)];
        } else {
            [path addLineToPoint:CGPointMake(x+centerX-delta, y)];
        }
        y -= 1;
    }
    
    return path;
}

#pragma mark Getter/Setter

- (NSMutableArray *)unusedLayers {
    
    if (!_unusedLayers) {
        _unusedLayers = [NSMutableArray array];
    }
    
    return _unusedLayers;
}

@end
