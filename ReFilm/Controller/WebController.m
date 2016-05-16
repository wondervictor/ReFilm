//
//  WebController.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "WebController.h"
#import <Masonry.h>

#define MAIN_HEIGHT   (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)

@interface WebController()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *mainWebView;
@property (nonatomic, strong) UIView *toolbar;


@end


@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initWebView];
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_toolbar];
    _toolbar.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@40);
    }];
    [self configureWebButtons];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadWeb:self.openURL];
}

- (void)initWebView {
    _mainWebView = [[WKWebView alloc]init];
    [self.view addSubview:_mainWebView];
    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top);
    }];
    _mainWebView.navigationDelegate = self;
}

- (void)loadWeb:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *reuqest = [NSURLRequest requestWithURL:url];
    [_mainWebView loadRequest:reuqest];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"Finish");
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"web:");
}


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
}

- (void)dealloc {
}

- (void)configureWebButtons {
    NSLog(@"df");
    UIButton *backButton = [UIButton new];
    [_toolbar addSubview:backButton];
    [backButton setTitle:@"后退" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];

    [backButton addTarget:self action:@selector(webViewBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toolbar.mas_left);
        make.height.equalTo(@40);
        make.bottom.equalTo(_toolbar.mas_bottom);
        make.width.equalTo([NSNumber numberWithFloat:MAIN_WIDTH/3.0]);
    }];
    
    
    UIButton *forwardButton = [UIButton new];
    [_toolbar addSubview:forwardButton];
    [forwardButton setTitle:@"前进" forState:UIControlStateNormal];
    [forwardButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];

    [forwardButton addTarget:self action:@selector(webViewForward:) forControlEvents:UIControlEventTouchUpInside];
    
    [forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right);
        make.height.equalTo(@40);
        make.bottom.equalTo(_toolbar.mas_bottom);
        make.width.equalTo([NSNumber numberWithFloat:MAIN_WIDTH/3.0]);
    }];
    
    
    UIButton *refreshButton = [UIButton new];
    [_toolbar addSubview:refreshButton];
    [refreshButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(webViewRefresh:) forControlEvents:UIControlEventTouchUpInside];
    
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forwardButton.mas_right);
        make.height.equalTo(@40);
        make.bottom.equalTo(_toolbar.mas_bottom);
        make.width.equalTo([NSNumber numberWithFloat:MAIN_WIDTH/3.0]);
    }];
    

}

- (void)webViewBack:(UIButton *)sender {
    [_mainWebView goBack];
}

- (void)webViewForward:(UIButton *)sender {
    [_mainWebView goForward];
}

- (void)webViewRefresh:(UIButton *)sender {
    [_mainWebView reload];
}

@end
