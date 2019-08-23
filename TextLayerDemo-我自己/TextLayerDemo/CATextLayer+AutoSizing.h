//
//  CATextLayer+AutoSizing.h
//  TextLayerDemo
//
//  Created by fengbang on 2019/8/23.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CATextLayer (AutoSizing)
- (CGSize) adjustBoundsToFit;
@end

NS_ASSUME_NONNULL_END
