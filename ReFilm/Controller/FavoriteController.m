//
//  FavoriteController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "FavoriteController.h"

@interface FavoriteController()

@end



@implementation FavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"收藏" image:nil tag:1];
    self.view.backgroundColor = [UIColor whiteColor];
}




@end
