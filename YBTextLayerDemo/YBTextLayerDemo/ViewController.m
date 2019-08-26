//
//  ViewController.m
//  YBTextLayerDemo
//
//  Created by 王迎博 on 2019/8/25.
//  Copyright © 2019年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "YBTextLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self verticallyAlignTextLayer];
}

#pragma mark - 自定义layer

- (void)verticallyAlignTextLayer {
    NSString *string = @"CALayer在概念和UIView类似，也是一些被层级关系树管理的矩形块，可以包含图片、文字、背景色等内容。CATextLayer是CALayer的子级，如果需要重新布局则可以重写drawInContext:方法";
    CGFloat originY = 150.f;
    CGFloat leftMargin = 30.f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 60;
    UIColor *color = [UIColor blueColor];
    UIFont *font = [UIFont boldSystemFontOfSize:15.f];
    CGSize limitSize = CGSizeMake(width, MAXFLOAT);
    CGSize strSize;
    
    YBTextLayer *textLayer = [YBTextLayer layer];
    textLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 10.0;
    paraStyle.paragraphSpacing = 0.;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.firstLineHeadIndent = 0.0;
    NSDictionary *attriDic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName:color};
    
    NSMutableAttributedString *mutAttriString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutAttriString addAttributes:attriDic range:NSMakeRange(0, string.length)];
    strSize = CGSizeMake(width, [self boundingHeightForLimitSize:limitSize withAttributedString:mutAttriString]);
    
    textLayer.frame = CGRectMake(leftMargin, originY, width, strSize.height);
    textLayer.foregroundColor = color.CGColor;
    textLayer.alignmentMode = kCAAlignmentLeft;
    textLayer.wrapped = YES;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.truncationMode = kCATruncationEnd;
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    textLayer.string = string;
    
    [self.view.layer addSublayer:textLayer];
    
    
    //添加markView
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(5, originY, 5, strSize.height)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    //添加label来比较显示
    CGSize labelSize = [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attriDic context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, originY+strSize.height + 50, width, labelSize.height)];
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = color;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = string;
    
    [self.view addSubview:label];
}

- (CGFloat)boundingHeightForLimitSize:(CGSize)limitSize withAttributedString:(NSAttributedString *)attributedString {
    
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)attributedString;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedStringRef);
    CFRange range = CFRangeMake(0, attributedString.length);
    CFRange fitCFRange = CFRangeMake(0, 0);
    CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, limitSize, &fitCFRange);
    if (nil != framesetter) {
        CFRelease(framesetter);
        framesetter = nil;
    }
    return ceilf(newSize.height);
}

@end
