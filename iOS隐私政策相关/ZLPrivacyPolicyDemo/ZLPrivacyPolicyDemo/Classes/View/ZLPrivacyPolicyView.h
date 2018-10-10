//
//  ZLPrivacyPolicyView.h
//  flower
//
//  Created by ZL on 2018/10/9.
//  Copyright © 2018年 alsd. All rights reserved.
//  隐私政策

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZLPrivacyPolicyView;

typedef enum : NSUInteger {
    ZLAlterViewStyleDefault,
    ZLAlertViewStyleWebView,
} ZLAlterViewStyle;

@protocol ZLPrivacyPolicyViewDelegate <NSObject>

@optional // 可选的
- (void)alertView:(ZLPrivacyPolicyView *)alertView clickedAtIndex:(NSInteger)buttonIndex;
@end

@interface ZLPrivacyPolicyView : UIView

@property (nonatomic, assign) id<ZLPrivacyPolicyViewDelegate> delegate;

/**
 *  不写默认是 ZLAlterViewStyleDefault
 */
@property (nonatomic, assign) ZLAlterViewStyle style;

- (UIWebView *)webViewOfAlter;

/**
 *  初始化自定义的 alterView
 *
 *  @param title             题目
 *  @param message           信息
 *  @param delegate          代理
 *  @param rightButtonTitle  右边第二个按钮
 *  @param otherButtonTitle 其他选择按钮
 *
 *  @return 实例对象
 */
- (instancetype)initWithTitle:(NSString *)title Message:(NSString *)message delegate:(id<ZLPrivacyPolicyViewDelegate>)delegate rightButtonTitle:(NSString *)rightButtonTitle otherButtonTitles:(NSString *)otherButtonTitle;

- (void)show;

@end

NS_ASSUME_NONNULL_END
