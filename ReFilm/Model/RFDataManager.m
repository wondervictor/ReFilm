//
//  RFDataManager.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFDataManager.h"
#import "RFNetworkManager.h"
#import "RFParser.h"
#import "MovieActor.h"
#import "CoreDataManager.h"




@interface RFDataManager()

@end

@implementation RFDataManager

+ (RFDataManager *)sharedManager {
    static RFDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    
    return sharedManager;
}

- (void)sendRequestForHotMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/in_theaters";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveHotMovieDataWith:movies error:nil];
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error : %@",errorMsg);
    }];
}

- (void)sendRequestForCommingMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/coming_soon";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error: %@",errorMsg);
    }];
}

- (void)sendRequestForTop100Movies {
    NSString *urlString = @"http://api.douban.com/v2/movie/top250";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {

    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error %@",errorMsg);
    }];
}

- (void)sendRequestSearchMovieWithName:(NSString *)movieName {
    NSString *url = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/search?q=%@",movieName];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *array = [RFParser parseForSearchMovie:responseObject];
        Movie *movie = [array firstObject];
        NSLog(@"movie name: %@",movie.movieName);
        
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error: %@",errorMsg);
    }];

}

- (void )handleTableCell:(MovieTableCell *)cell withMovie:(Movie *)movie {
    cell.movieName.text = movie.movieName;
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    UIImage *image = [UIImage imageWithData:imageData scale:1];
    cell.movieImage.image = image;
    
    NSMutableString *directors = [NSMutableString new];
    [directors appendString:@"导演:"];
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    for (MovieActor *actor in movie.movieActors) {
        [actors appendFormat:@" %@",actor.name];
    }
    for (MovieActor *director in movie.movieDirectors) {
        [directors appendFormat:@" %@",director.name];
    }
    cell.actorsLabel.text = actors;
    cell.directorLabel.text = directors;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%f",movie.averageRating];
}


@end
