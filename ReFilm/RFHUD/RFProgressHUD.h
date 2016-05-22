//
//  RFProgressHUD.h
//  ReFilm
//
//  Created by VicChan on 5/14/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RFProgressHUDType) {
    RFProgressHUDTypeDefault,
    RFProgressHUDTypeError,
    RFProgressHUDTypeSuccess
};


@interface RFProgressHUD : UIView


@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, getter=isAnimating) BOOL animated;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) UIView *parentView;

@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, strong) UIColor *tintColor;




- (id)initWithFrame:(CGRect)frame;

- (id)initWithSize:(CGSize)size center:(CGPoint)point duration:(CGFloat)duration toView:(UIView *__weak )view;

/// 开始
- (void)startAnimating;
/// 结束
- (void)stopAnimating;
/// 成功
- (void)stopWithSuccess:(NSString *)succesMsg;
/// 错误
- (void)stopWithError:(NSString *)errorMsg;
/// 
- (void)startAnimatingWithTitle:(NSString *)title;

@end
