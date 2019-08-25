//
//  YBTextLayer.m
//  TextLayerDemo
//
//  Created by fengbang on 2019/8/23.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "YBTextLayer.h"
#import <UIKit/UIKit.h>

@implementation YBTextLayer
- (void)drawInContext:(CGContextRef)ctx {
    
//    CGFloat height = self.bounds.size.height;
//    CGFloat fontSize = self.fontSize;
//    CGFloat yDiff = (height-fontSize)/2 - fontSize/10;
//    yDiff = 150;
//    [super drawInContext:ctx];
//    UIGraphicsPushContext(ctx);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, 0, yDiff);
//    CGContextRestoreGState(context);
//    UIGraphicsPopContext();

    
    
//    UIGraphicsPushContext(ctx);
//    //创建圆形框UIBezierPath:
//    UIBezierPath *pickingFieldPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    //创建外围大方框UIBezierPath:
//    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:self.bounds];
//    //将圆形框path添加到大方框path上去，以便下面用奇偶填充法则进行区域填充：
//    [bezierPathRect appendPath:pickingFieldPath];
//    [[[UIColor blackColor] colorWithAlphaComponent:0.5] set];
//    //填充使用奇偶法则
//    bezierPathRect.usesEvenOddFillRule = YES;
//    [bezierPathRect fill];
//    [[UIColor redColor] set];
//    [pickingFieldPath setLineWidth:2];
//    [pickingFieldPath stroke];
//    UIGraphicsPopContext();
//    self.contentsGravity = kCAGravityCenter;
    
    
    
    CGFloat height = self.bounds.size.height;
    CGFloat fontSize = self.fontSize;
    CGFloat yDiff = (height - fontSize)/2.0 - fontSize/5.0;///10.0;
    
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0.0, yDiff);
    [super drawInContext:ctx];
    CGContextRestoreGState(ctx);
}

@end
