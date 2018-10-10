//
//  ZLHtmlController.m
//  ZLPrivacyPolicyDemo
//
//  Created by ZL on 2018/10/10.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "ZLHtmlController.h"
#import "HConst.h"
//#import <NSObject+QMShow.h>


@interface ZLHtmlController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *web;

@end

@implementation ZLHtmlController

#pragma mark - 懒加载

- (UIWebView *)web {
    if (!_web) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, HScreenW, HScreenH)];
        // UIWebView加载过程中，在页面没有加载完毕前，会显示一片空白。为解决这个问题，方法如下：让UIWebView背景透明。
        web.backgroundColor = [UIColor clearColor];
        web.opaque = NO;
        [web setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"web.png"]]];
        [self.view addSubview:web];
        
        _web = web;
    }
    return _web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"'XX’隐私政策";
    
    self.view.backgroundColor = HRGBColor(246, 247, 248);
    
    // 请求网页
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", @"http://www.baidu.com"]]]];
    // 读取本地网页
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"本应用隐私政策" ofType:@"webarchive"]]];
    
    [self.web loadRequest:request2];
    
    self.web.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
//    [self mix_NSObjecte_showProgress];
}

// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
//    [self mix_NSObjecte_hideProgress];
}

// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
//    [self mix_NSObjecte_hideProgress];
}


@end
