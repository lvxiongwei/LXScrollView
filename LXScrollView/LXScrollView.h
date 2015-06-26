//  LXScrollView.h
//  Created by LX on 15/5/13.

#import <UIKit/UIKit.h>

@protocol LXScrollViewDelegate;

@interface LXScrollView : UIView

@property (nonatomic,assign)id<LXScrollViewDelegate> delegate;

// 初始化轮播视图,可以传图片和地址数组，传地址时要打开.m文件中的图片下载功能
- (instancetype)initWithFrame:(CGRect)frame contentImages:(NSArray *)images;

@end

@protocol LXScrollViewDelegate <NSObject>

@optional

// 点击图片事件代理
-(void)touchPicAtIndex:(int)index;

@end