//
//  RFNetworkManager.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ComplitionBlock) (NSDictionary * responseObject, NSURLResponse * response);
typedef void (^ErrorBlock) (NSError *error, NSString *errorMsg);

@interface RFNetworkManager : NSObject

+ (RFNetworkManager *)sharedManager;

/**
 *  @name 请求正在热映电影
 *
 **/

- (void)requestMovieDataWithURL:(NSString *)urlString success:(ComplitionBlock)success failure:(ErrorBlock)failure;



@end
