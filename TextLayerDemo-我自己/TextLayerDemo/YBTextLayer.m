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
    
    CGFloat height = self.bounds.size.height;
    CGFloat fontSize = self.fontSize;
    CGFloat yDiff = (height-fontSize)/2 - fontSize/10;
    
    [super drawInContext:ctx];
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, yDiff);
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}

@end
