//
//  ZYTextToolView.h
//  ZYTextView
//
//  Created by zhuyongqing on 2017/7/1.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYTextToolViewDelegate <NSObject>

- (void)textToolViewSendButtonAction:(NSString *)text;

@end

@interface ZYTextToolView : UIView

@property(nonatomic,assign) id<ZYTextToolViewDelegate> delegate;


@end
