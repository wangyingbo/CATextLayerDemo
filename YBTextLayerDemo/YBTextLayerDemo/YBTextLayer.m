//
//  YBTextLayer.m
//  YBTextLayerDemo
//
//  Created by 王迎博 on 2019/8/25.
//  Copyright © 2019年 王颖博. All rights reserved.
//

#import "YBTextLayer.h"
#import <UIKit/UIKit.h>

@implementation YBTextLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    CGFloat height = self.bounds.size.height;
    CGFloat fontSize = self.fontSize;
    NSString *fontName = (__bridge NSString *)CGFontCopyPostScriptName((CGFontRef)self.font);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    CGFloat lines = height/font.lineHeight;
    CGFloat yDiff = (height - fontSize*lines)/2.0;
    if (lines<2) {
        yDiff = (height - fontSize)/2 - fontSize/5;
    }
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0.0, yDiff);
    [super drawInContext:ctx];
    CGContextRestoreGState(ctx);
}

@end
