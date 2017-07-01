//
//  ZYTextToolView.m
//  ZYTextView
//
//  Created by zhuyongqing on 2017/7/1.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ZYTextToolView.h"
#import "ZYTextView.h"
#import "UIView+ITTAdditions.h"
#import "UIView+ITTAdditions.h"
@interface ZYTextToolView()<UITextViewDelegate>

@property(nonatomic,strong) ZYTextView *textView;

@property(nonatomic,strong) UIButton *sendBtn;



@end

#define KWinSize  [UIScreen mainScreen].bounds.size

#define KTopSpace 5

@implementation ZYTextToolView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        [self initSubviews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{

    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];

    [UIView beginAnimations:@"changeViewContentInset" context:NULL];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationCurve:(UIViewAnimationCurve) animationCurve];
    
    
    
    self.z_top = KWinSize.height - height - self.z_height;
    
    
    [UIView commitAnimations];
    
}


- (void)keyboardWillHidden:(NSNotification *)notification
{

    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    
    [UIView beginAnimations:@"changeViewContentInset" context:NULL];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationCurve:(UIViewAnimationCurve) animationCurve];
    
    self.z_bottom = KWinSize.height;
    
    
    [UIView commitAnimations];
}

- (void)initSubviews{
    
    _textView = [[ZYTextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.placeholdText = @"placehold";
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.borderWidth = .5;
    _textView.keyboardType = UIReturnKeyDone;
    _textView.delegate = self;
    [self addSubview:_textView];
    
    _sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendBtn];
    
    [_textView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.sendBtn sizeToFit];
    CGFloat Space = 15;
    self.sendBtn.frame = CGRectMake(self.z_width - Space - self.sendBtn.z_width, 0, self.sendBtn.z_width, self.sendBtn.z_height);
    self.sendBtn.z_centerY = self.z_height/2;
    self.textView.frame = CGRectMake(Space, KTopSpace, self.z_width - Space * 3 - self.sendBtn.z_width, self.z_height - KTopSpace*2);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGRect textViewRect = [change[@"new"] CGRectValue];
    CGFloat height = textViewRect.size.height + KTopSpace*2;
    self.z_top -= height - self.z_height;
    self.z_height = height;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)sendButtonAction{
    [self.textView resignFirstResponder];
    if (!self.textView.text.length) return;
    //////
    if (self.delegate && [self.delegate respondsToSelector:@selector(textToolViewSendButtonAction:)]) {
        [self.delegate textToolViewSendButtonAction:self.textView.text];
    }
}

- (void)dealloc{
    [_textView removeObserver:self forKeyPath:@"bounds"];
}

@end
