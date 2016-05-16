//
//  DetailController.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "DetailController.h"

@interface DetailController()

@end


@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细信息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureSubViews];
}

- (void)configureSubViews {
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"favoriteButton"] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = favoriteButton;
}

- (void)favoriteButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Favorite");
}


@end
