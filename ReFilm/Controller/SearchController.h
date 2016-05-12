//
//  SearchController.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchControllerDelegate <NSObject>

- (void)popOut;

@end


@interface SearchController : UIViewController


@property (nonatomic, weak) id<SearchControllerDelegate> delegate;

@end
