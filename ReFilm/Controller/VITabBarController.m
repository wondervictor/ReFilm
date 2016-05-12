//
//  VITabBarController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "VITabBarController.h"
#import "MasterViewController.h"
#import "FavoriteController.h"
#import "SettingController.h"


#import "UIImage+TintColor.h"




@implementation VITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance]setTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:[MasterViewController new]];
    [self addOneChildController:navi1 withTitle:@"发现" image:[UIImage imageNamed:@"world"]];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:[FavoriteController new]];
    [self addOneChildController:navi2 withTitle:@"收藏" image:[UIImage imageNamed:@"favorite"]];    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:[SettingController new]];
    [self addOneChildController:navi3 withTitle:@"设置" image:[UIImage imageNamed:@"setting"]];
    
    [self setUpTabBarItemTextAttributes];
    
}

- (void)setUpTabBarItemTextAttributes{
    
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor greenColor];
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


- (void)addOneChildController:(UIViewController *)controller withTitle:(NSString *)title image:(UIImage *)image {
    //  controller.tabBarItem.
    controller.tabBarItem.title = title;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.image = [image imageWithColor:[UIColor grayColor]];
    
    UIImage *selectedImage = [image imageWithColor:[UIColor greenColor]];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:controller];
}





@end
