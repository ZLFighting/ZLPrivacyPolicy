//
//  HRHeader.h
//
//  Created by hare27 on 16/2/1.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 只在oc的文件中，才能起作用*/
#ifdef __OBJC__



/** 自定义log*/
#ifdef DEBUG
#define HLog(...) NSLog(@"%s %s %d \n %@\n\n",__FILE__,__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define HLog(...)
#endif

#define ud [NSUserDefaults standardUserDefaults]

/** 随机整数*/
/** [0,x)*/                                                        
#define HRandInt(x) (arc4random()%x)
/** [0,256)*/
#define HRand256 HRandInt(256)

/** rgb颜色*/
#define HRGBColor(r, g, b) HRGBAColor(r, g, b, 255)
#define HRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

/** 随机色*/
#define HRandColor HRGBAColor(HRand256, HRand256, HRand256, 255)
#define HRandAColor HRGBAColor(HRand256, HRand256, HRand256, HRand256)

/** 屏幕宽*/
#define HScreenW [UIScreen mainScreen].bounds.size.width

/** 屏幕高*/
#define HScreenH [UIScreen mainScreen].bounds.size.height

// 设置尺寸
#define UI_View_Width   ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度
#define UI_View_Height  ([UIScreen mainScreen].bounds.size.height) // 屏幕高度
#define UI_navBar_Height  ((UI_View_Height == 812) ? 88.0 : 64.0) // 导航条高度
#define NAVIGATION_BAR_HEIGHT   ((UI_View_Height == 812) ? 68.0 : 44.0f)
#define STATUS_BAR_HEIGHT               20.0f // 状态栏高度
#define UI_tabBar_Height  ((UI_View_Height == 812) ? 83.0 : 49.0) // 底部tabbar高度

// 隐私政策网址
#define ZLPrivacyPolicyURL  (@"https://www.jianshu.com/p/333c2005351f")

#endif
