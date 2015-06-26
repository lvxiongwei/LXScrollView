//  LXScrollView.m
//  Created by LX on 15/5/13.

#import "LXScrollView.h"
//#import "UIImageView+WebCache.h"

@interface LXScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LXScrollView

// 初始化轮播视图
- (instancetype)initWithFrame:(CGRect)frame contentImages:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        _images = [images copy];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*[_images count], _scrollView.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        [self addContentImage];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-25, self.frame.size.width, 25)];
        _pageControl.numberOfPages = [_images count];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];

        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoScrollImage) userInfo:nil repeats:YES];
    }
    return self;
}

// 添加内容图片
- (void)addContentImage
{
    if (_images == nil || [_images count] == 0) {
        return;
    }
    
    for (int index = 0;index <= [_images count];index++) {//多加一个Image在最后面加一个第一张图片
        CGFloat originX = self.frame.size.width*index;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, 0, self.frame.size.width, self.frame.size.height)];
        imageView.tag = index;
        UIImage *image;
        
        if (index == [_images count]) {//最后一张是第一张图片,为了动画效果
            image = [_images objectAtIndex:0];
        }
        else{
            image = [_images objectAtIndex:index];
        }
       
        if ([image isKindOfClass:[NSString class]]) {
            //[imageView setImageWithURL:[NSURL URLWithString:(NSString *)image ] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else imageView.image = image;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPicAtIndex:)];
        tap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
}

// 点击图片事件
-(void)touchPicAtIndex:(UITapGestureRecognizer *)sender{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(touchPicAtIndex:)]) {
        [_delegate touchPicAtIndex:(int)sender.self.view.tag];
    }
}

//自动切换图片
- (void)autoScrollImage
{
    if (_pageControl.currentPage == [_images count]-1) {
        _pageControl.currentPage = 0;
        [UIView animateWithDuration:0.5 animations:^{
             _scrollView.contentOffset = CGPointMake(self.frame.size.width*[_images count], 0);
        } completion:^(BOOL finished) {
             _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    else{
        _pageControl.currentPage += 1;
        [UIView animateWithDuration:0.5 animations:^{
             _scrollView.contentOffset = CGPointMake(self.frame.size.width*_pageControl.currentPage, 0);
        }];
    }
}

#define UIScrollViewDelegate scrollVeiw代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出水平方向上滚动的距离
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    // 求出页码
    int currentPage = (int)(contentOffsetX/self.frame.size.width + 0.5);
    _pageControl.currentPage = currentPage;
}

@end
