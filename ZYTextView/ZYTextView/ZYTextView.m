//
//  ZYTextView.m
//  ZYTextView
//
//  Created by zhuyongqing on 2017/7/1.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ZYTextView.h"

@interface ZYTextView()

@property(nonatomic,strong) UILabel *placehold;


@end


@implementation ZYTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollEnabled = NO;
        [self initPlacehold];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)initPlacehold{
    _placehold = [[UILabel alloc] init];
    _placehold.font = [UIFont systemFontOfSize:14];
    _placehold.textColor = [UIColor grayColor];
    
    [self addSubview:_placehold];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftspace = 5;
    [self.placehold sizeToFit];
    self.placehold.frame = CGRectMake(leftspace, 0, CGRectGetWidth(self.placehold.bounds), CGRectGetHeight(self.placehold.bounds));
    CGPoint center  = self.placehold.center;
    center.y = CGRectGetHeight(self.bounds)/2;
    self.placehold.center = center;
    
}

- (void)setPlaceholdFont:(UIFont *)placeholdFont{
    self.placehold.font = placeholdFont;
    [self layoutSubviews];
}

- (void)setPlaceholdText:(NSString *)placeholdText{
    self.placehold.text = placeholdText;
}

- (void)setPlaceholdTextColor:(UIColor *)placeholdTextColor{
    self.placehold.textColor = placeholdTextColor;
}

- (void)textViewChanged{
    
    CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT)];
    
    CGRect newRect = self.bounds;
    
    newRect.size.height = size.height;
    
    self.bounds = newRect;
    
    self.placehold.hidden = self.text.length;
}

@end
