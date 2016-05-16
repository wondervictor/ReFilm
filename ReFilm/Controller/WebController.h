//
//  WebController.h
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebController : UIViewController

@property (nonatomic, strong) NSString *openURL;

- (void)loadWeb:(NSString *)urlString;

@end
