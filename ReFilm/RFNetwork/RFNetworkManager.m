//
//  RFNetworkManager.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFNetworkManager.h"
#import "ReFilm-Swift.h"


@interface RFNetworkManager()

@property (nonatomic, strong) NSURLSession *session;


@end


@implementation RFNetworkManager

+ (RFNetworkManager *)sharedManager {
    static RFNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    return sharedManager;
}

- (NSURLSession *)session {
    if (_session == nil) {

        _session = [NSURLSession sharedSession];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 60;
        configuration.allowsCellularAccess = YES;
        _session = [NSURLSession sessionWithConfiguration:configuration];

    }
    return _session;
    
}

- (void)requestMovieDataWithURL:(NSString *)urlString success:(ComplitionBlock)success failure:(ErrorBlock)failure {
    // UTF8 - encoding
    NSString *finalUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc]initWithString:finalUrlString];
    NSLog(@"%@",url);
    
    

// TODO: reachablity
    /*
    RFReachableManager *managr = [[RFReachableManager alloc]init];
    [managr checkNetWorkCondition];
     */
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url
                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                             if (!error) {

                                                 NSError *jsonError = nil;
                                                 id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                                                 success(dict,response);
                                                 
                                             }
                                             else {
                                                 NSString *errorMsg = error.localizedFailureReason;
                                                 failure(error,errorMsg);
                                             }
                                             
                                         } ];
    
    [task resume];

}





@end
