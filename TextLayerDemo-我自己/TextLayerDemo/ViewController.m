//
//  ViewController.m
//  TextLayerDemo
//
//  Created by fengbang on 2019/8/23.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "CATextLayer+AutoSizing.h"
#import "YBTextLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self test1];
    
    //[self catextLayer];
    
    //[self test2];
    
    //[self test3];
}

- (void)test1 {
    NSString *string = @"江南";
    CGFloat originY = 150.f;
    CGFloat leftMargin = 30.f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 60;
    UIColor *color = [UIColor blueColor];
    
    UIFont *font = [UIFont boldSystemFontOfSize:150.f];
    YBTextLayer *textLayer = [YBTextLayer layer];
    textLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 0.0;
    paraStyle.paragraphSpacing = 0.;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.firstLineHeadIndent = 0.0;
    NSDictionary *attriDic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle};
    CGSize limitSize = CGSizeMake(width, MAXFLOAT);
    NSMutableAttributedString *mutAttriString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutAttriString addAttributes:attriDic range:NSMakeRange(0, string.length)];
    CGSize strSize;
    
    
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    if (string != nil)
        CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), (CFStringRef)string);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTForegroundColorAttributeName, color.CGColor);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTFontAttributeName, (__bridge CFStringRef)font);
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CTParagraphStyleSetting settings[] = {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    NSMutableAttributedString *ret = (__bridge NSMutableAttributedString *)attrString;
    

    
    //strSize = [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attriDic context:nil].size;
    //strSize = [self sizeWithString:string font:font limitSize:limitSize];
    strSize = CGSizeMake(width, [self boundingHeightForWidth:limitSize withAttributedString:ret]);
    
    
    textLayer.frame = CGRectMake(leftMargin, originY, width, strSize.height);
    textLayer.foregroundColor = color.CGColor;
    textLayer.alignmentMode = kCAAlignmentLeft;
    textLayer.wrapped = YES;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.truncationMode = kCATruncationNone;
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    textLayer.string = string;
    
    [self.view.layer addSublayer:textLayer];
    
    //[textLayer adjustBoundsToFit];
    
    
//    CGSize textSize = [string sizeWithAttributes:attriDic];
//    CGRect frame = textLayer.frame;
//    frame.size = textSize;
//    textLayer.frame = frame;
    
    
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(5, originY, 5, strSize.height)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, originY+strSize.height + 50, width, strSize.height)];
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = color;
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = string;
    [self.view addSubview:label];
}

- (CGFloat)boundingHeightForWidth:(CGSize)limitSize withAttributedString:(NSAttributedString *)attributedString {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFMutableAttributedStringRef) attributedString);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, limitSize, NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font limitSize:(CGSize)limitSize {
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 100;
    NSMutableAttributedString *attibuteStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attibuteStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    [attibuteStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)attibuteStr;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedStringRef);
    CFRange range = CFRangeMake(0, string.length);
    CFRange fitCFRange = CFRangeMake(0, 0);
    CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, limitSize, &fitCFRange);
    if (nil != framesetter) {
        CFRelease(framesetter);
        framesetter = nil;
    }
    return CGSizeMake(ceilf(newSize.width), ceilf(newSize.height));
}





- (void)catextLayer {
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 300, 300)];
    labelView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:labelView];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = labelView.bounds;
    [labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentLeft;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:120];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"CALayer在概念和UIView类似，也是一些被层级关系树管理的矩形块，可以包含图片、文字、背景色等内容。和UIView的最大不同是不能够处理与用户的交互。每一个UIView都有个CALayer实例的图层属性，被称为backing layer，由视图负责创建并管理这个图层，以确保当子视图在层级关系中添加或被移除时，对应的关联图层也有相同的操作。";
    text = @"啊哈";
    
    textLayer.position = labelView.center;
    textLayer.string = text;
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGRect frame = labelView.frame;
    frame.size = textSize;
    labelView.frame = frame;
    textLayer.frame = labelView.bounds;
    
}

- (void)test2 {
    NSString *str = @"CALayer在概念和UIView类似，也是一些被层级关系树管理的矩形块，可以包含图片、文字、背景色等内容。和UIView的最大不同是不能够处理与用户的交互。";
    CATextLayer *layer = [CATextLayer layer];
    //设置渲染的方式
    layer.contentsScale = [UIScreen mainScreen].scale;
    
    //如果没有设置其他样式的情况下，使用下边的代码能让我计算的高度准确一点
    //有办法计算高度准确的，请一定要联系我告诉我。。
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 1;
    
    //字体颜色
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:paragraph}];
    //字体大小
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, str.length)];
    
    layer.string = attributedStr;
    //计算字体高度
    layer.bounds = [attributedStr boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    //换行
    layer.wrapped = YES;
    //裁剪方式
    layer.truncationMode = kCATruncationEnd;
    //对齐
    layer.alignmentMode = kCAAlignmentNatural;
    [self.view.layer addSublayer:layer];
}

-(void)test3 {
    
    CATextLayer *text1 = [self attributeLayer:@"CALayer在概念和UIView类似，也是一些被层级关系树管理的矩形块，可以包含图片、文字、背景色等内容。和UIView的最大不同是不能够处理与用户的交互。" width:300 textColor:[UIColor redColor]];
    text1.backgroundColor = [UIColor lightGrayColor].CGColor;
    text1.position = self.view.center;
    [self.view.layer addSublayer:text1];
}

- (CATextLayer *)attributeLayer:(NSString *)str width:(CGFloat)width textColor:(UIColor *)color{
    CATextLayer *layer = [CATextLayer layer];
    //设置渲染的方式
    layer.contentsScale = [UIScreen mainScreen].scale;
    
    //如果没有设置其他样式的情况下，使用下边的代码能让我计算的高度准确一点
    //有办法计算高度准确的，请一定要联系我告诉我。。
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 1;
    
    //字体颜色
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph}];
    //字体大小
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, str.length)];
    
    layer.string = attributedStr;
    //计算字体高度
    layer.bounds = [attributedStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    //换行
    layer.wrapped = YES;
    //裁剪方式
    layer.truncationMode = kCATruncationEnd;
    //对齐
    layer.alignmentMode = kCAAlignmentNatural;
    return layer;
}
@end
