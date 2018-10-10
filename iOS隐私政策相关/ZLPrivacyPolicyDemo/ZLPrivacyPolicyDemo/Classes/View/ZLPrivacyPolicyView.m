//
//  ZLPrivacyPolicyView.m
//  flower
//
//  Created by ZL on 2018/10/9.
//  Copyright © 2018年 alsd. All rights reserved.
//

#import "ZLPrivacyPolicyView.h"
#import "HConst.h"


@interface ZLPrivacyPolicyView () <UIWebViewDelegate>

@property (nonatomic, weak) UIView *bgView;
// 全屏按钮，用来点击使textView消失
@property (weak, nonatomic) UIButton *cover;
@property (nonatomic, weak) UIButton *deleBtn;
// 题目
@property (nonatomic, weak) UILabel *titleLabel;
// 中间内容
@property (nonatomic, weak) UILabel *messageLabel;
// webView
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIButton *otherBtn;

@property (nonatomic, weak) UIView *horizontalLine;
@property (nonatomic, weak) UIView *verticalLine;

@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation ZLPrivacyPolicyView


- (instancetype)initWithTitle:(NSString *)title Message:(NSString *)message delegate:(id<ZLPrivacyPolicyViewDelegate>)delegate rightButtonTitle:(NSString *)rightButtonTitle otherButtonTitles:(NSString *)otherButtonTitle {
    ZLPrivacyPolicyView *alter = [[ZLPrivacyPolicyView alloc] init];
    alter.delegate = delegate;
    alter.backgroundColor = [UIColor whiteColor];
    alter.style = ZLAlterViewStyleDefault;
    
    // x按钮
    UIButton *deleBtn = [[UIButton alloc] init];
    [deleBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [deleBtn addTarget:alter action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [alter addSubview:deleBtn];
    alter.deleBtn = deleBtn;
    
    // 题目
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = HRGBColor(102, 102, 102);
    alter.titleLabel = titleLabel;
    [alter addSubview:titleLabel];
    
    // 中间内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1];
    messageLabel.numberOfLines = 0;
    alter.messageLabel = messageLabel;
    [alter addSubview:messageLabel];
    
    // 横线
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = HRGBColor(217, 217, 217);
    [alter addSubview:horizontalLine];
    alter.horizontalLine = horizontalLine;
    
    // other按钮
    if (otherButtonTitle) {
        
        UIButton *otherBtn = [[UIButton alloc] init];
        [otherBtn setTitle:otherButtonTitle forState: UIControlStateNormal];
        otherBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [otherBtn setTitleColor:[UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        [otherBtn addTarget:alter action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [alter addSubview:otherBtn];
        alter.otherBtn = otherBtn;
        [alter.btnArray addObject:otherBtn];
        
        UIView *verticalLine = [[UIView alloc] init];
        verticalLine.backgroundColor = HRGBColor(217, 217, 217);
        [alter addSubview:verticalLine];
        alter.verticalLine  = verticalLine;
    }
    
    // 右边按钮
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:rightButtonTitle forState: UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [rightBtn setTitleColor:HRGBColor(251, 0, 7) forState:UIControlStateNormal]; // 红色
    [rightBtn addTarget:alter action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [alter addSubview:rightBtn];
    alter.rightBtn = rightBtn;
    [alter.btnArray addObject:rightBtn];
    
    alter.layer.cornerRadius = 8;
    alter.layer.masksToBounds = YES;
    // 选择按钮
    /* 可变参数写法
     NSString *curStr;
     va_list list;
     if (otherButtonTitles) {
     NSLog(@"%@", otherButtonTitles);
     
     va_start(list, otherButtonTitles);
     while ((curStr = va_arg(list, NSString *))) {
     NSLog(@"%@", curStr);
     }
     va_end(list);
     }
     */
    
    
    return alter;
}

- (void)deleteClick:(UIButton *)btn {
    [self dismiss];
}

- (void)show {
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = HRGBColor(0, 0, 0);
    bgView.alpha = 0.6;
    self.bgView = bgView;
    
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    // 背景蒙层
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:cover];
    self.cover = cover;
    [cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismiss {
    [self.bgView removeFromSuperview];
    [self.cover removeFromSuperview];
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat marginX = 17;
    CGFloat btnH = 50;
    
    CGFloat w = 300;
    CGFloat h = 260;
    CGFloat x = (UI_View_Width - w) * 0.5;
    CGFloat y = (UI_View_Height - h) * 0.5;
    self.frame = CGRectMake(x, y, w, h);
    self.cover.frame = self.bgView.frame;
    self.deleBtn.frame = CGRectMake(self.frame.size.width - 8 - 20, 8, 20, 20);

    self.titleLabel.frame = CGRectMake(marginX, 10, self.frame.size.width - 2 * marginX, 20);
    
    if (self.style == ZLAlterViewStyleDefault) {
        self.messageLabel.frame = CGRectMake(marginX, CGRectGetMaxY(self.titleLabel.frame) + 20, self.frame.size.width - 2 * marginX, 140);
    } else {
        self.webView.frame = CGRectMake(marginX, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width - 2 * marginX, 175);
    }

    self.horizontalLine.frame = CGRectMake(0, h - btnH - 1, self.frame.size.width, 1);
    
    if (self.otherBtn) {
        self.otherBtn.frame = CGRectMake(0, h - btnH, self.frame.size.width * 0.5, btnH);
        self.rightBtn.frame = CGRectMake(self.frame.size.width *0.5, h - btnH, self.frame.size.width * 0.5, btnH);
        self.verticalLine.frame = CGRectMake(self.frame.size.width * 0.5, h - btnH, 1, btnH);
    } else {
        self.rightBtn.frame = CGRectMake(0, h - btnH, self.frame.size.width, btnH);
    }
}

- (void)click:(UIButton *) btn {
    if ([self.delegate respondsToSelector:@selector(alertView:clickedAtIndex:)]) {
        
        [self.delegate alertView:self clickedAtIndex:[self.btnArray indexOfObject:btn]];
    }
    [self dismiss];
}

- (void)setStyle:(ZLAlterViewStyle)style {
    _style = style;
    switch (style) {
        case ZLAlterViewStyleDefault:

            break;
            
        case ZLAlertViewStyleWebView: {
            UIWebView *webView = [[UIWebView alloc] init];
            
            [self addSubview:webView];
            self.webView = webView;
            self.webView.delegate = self;
            // 请求网页
//            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", ZLPrivacyPolicyURL]]];
            NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"本应用隐私政策" ofType:@"webarchive"]]];
            
            [self.webView loadRequest:request];
            
            break;
        }
            
        default:
            break;
    }
}

- (UIWebView *)webViewOfAlter {
    return self.webView;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

#pragma mark - 懒加载

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        NSMutableArray *array = [NSMutableArray array];
        _btnArray = array;
    }
    return _btnArray;
}

- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        // UIWebView加载过程中，在页面没有加载完毕前，会显示一片空白。为解决这个问题，方法如下：让UIWebView背景透明。
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = NO;
        [webView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"web.png"]]];
        [self addSubview:webView];
        
        _webView = webView;
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate

// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
//    [self showProgress];
}

// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
//    [self hideProgress];
}

// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
//    [self hideProgress];
}


@end
