//
//  ViewController.m
//  ZLPrivacyPolicyDemo
//
//  Created by ZL on 2018/10/9.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "ViewController.h"
#import "ZLPrivacyPolicyView.h"
#import "ZLHtmlController.h"
#import "HConst.h"

@interface ViewController () <ZLPrivacyPolicyViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 显示隐私政策弹框
    ZLPrivacyPolicyView *ppalert = [[ZLPrivacyPolicyView alloc] initWithTitle:@"'XX’隐私政策" Message:@"" delegate:self rightButtonTitle:@"确定" otherButtonTitles:@"详情"];
    ppalert.style = ZLAlertViewStyleWebView;
    
    //  读取本地版本号 来处理是否显示显示隐私政策弹框
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本(存储在沙盒的版本号)
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号(在info.plist文件中获取)
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {// 版本号相同：这次打开和上次打开的是同一个版本
        
        ppalert.hidden = YES;
    } else {// 这次打开的版本和上一次不一样，显示弹框
        
        ppalert.hidden = NO;
        [ppalert show];
        
        // 将当前版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//synchronize:同步 不可少这句！！！
    }
}

#pragma mark - ZLPrivacyPolicyViewDelegate

- (void)alertView:(ZLPrivacyPolicyView *)alertView clickedAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) { // 隐私详情
        
       // 跳转网页
        NSLog(@"点击了跳转隐私详情网页");
        
        ZLHtmlController *vc = [[ZLHtmlController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
