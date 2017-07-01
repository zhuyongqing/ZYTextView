//
//  ZYTextView.h
//  ZYTextView
//
//  Created by zhuyongqing on 2017/7/1.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTextView : UITextView

@property(nonatomic,copy) NSString *placeholdText;

@property(nonatomic,strong) UIColor *placeholdTextColor;

@property(nonatomic,strong) UIFont *placeholdFont;


@end
