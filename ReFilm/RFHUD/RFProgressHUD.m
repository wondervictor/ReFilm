//
//  RFProgressHUD.m
//  ReFilm
//
//  Created by VicChan on 5/14/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFProgressHUD.h"
#define VIEW_WIDTH   (self.frame.size.width)
#define VIEW_HEIGHT  (self.frame.size.height)

@interface RFProgressHUD()

@property (nonatomic, assign) RFProgressHUDType currentType;

@end

@implementation RFProgressHUD

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // default Configuration
        _duration = 0.5f;
        _animated = NO;
        self.layer.cornerRadius = 5.0f;
        
    }
    return self;
}

- (id)initWithSize:(CGSize)size center:(CGPoint)point duration:(CGFloat)duration toView:(UIView *__weak)view {
    
    self = [super initWithFrame:CGRectMake(point.x-size.width/2.0, point.y-size.height/2, size.width, size.height)];
    if (self) {
        _duration = duration;
        _parentView = view;
        _animated = NO;
        
        
    }
    return self;
}

- (void)startAnimating {
    _animated = YES;
}


- (void)stopAnimating {
    _animated = NO;
}

- (void)stopWithError:(NSString *)errorMsg {
    
}

- (void)stopWithSuccess:(NSString *)succesMsg {
    
}

- (void)defaultState {
    //UIBezierPath *mainPath = [UIBezierPath alloc];
}

- (void)startAnimatingWithTitle:(NSString *)title {
    
}




@end
