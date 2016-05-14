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

#import "FavorieMovies+CoreDataProperties.h"
#import "FavorieMovies.h"


@interface RFDataManager()

@property (nonatomic, strong) CoreDataManager *coreDataManager;

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
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveCommingMovies:movies error:nil];
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error: %@",errorMsg);
    }];
}

- (void)sendRequestForTop100Movies {
    NSString *urlString = @"http://api.douban.com/v2/movie/top250";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveTopMovies:movies error:nil];
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
        [_delegate didReceiveSearchMovies:array error:nil];
        
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error: %@",errorMsg);
    }];

}

- (void)sendRequestForMovieWithID:(NSString *)movieID {
    NSString *url = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@",movieID];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"----%@",responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        
    }];
}

- (void)sendRequestForCommentWithMovieID:(NSString *)movieID {
    NSString *url = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@/comments",movieID];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"----%@",responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        
    }];
}



#pragma mark - Perisistent Store

- (CoreDataManager *)coreDataManager {
    if (_coreDataManager == nil) {
        _coreDataManager = [[CoreDataManager alloc]init];
        [_coreDataManager setStore];
    }
    return _coreDataManager;
}


- (void)addFavoriteMovie:(Movie *)movie {
    
    NSArray *list = [self getAllFavoriteMovies];
    
    for (FavorieMovies *fmovie in list ) {
        if ([fmovie.movieID isEqualToString:movie.movieID]) {
            return;
        }
    }
    
    FavorieMovies *fmovie = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteMovies" inManagedObjectContext:self.coreDataManager.context];
    
    fmovie.movieName = movie.movieName;
    fmovie.movieID = movie.movieID;
    fmovie.alt = movie.alt;
    fmovie.averageRating = [NSNumber numberWithFloat:movie.averageRating];
    fmovie.year = movie.year;
    fmovie.movieImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    fmovie.imageURL = movie.imageURL;
    
    NSData *actorData = [NSKeyedArchiver archivedDataWithRootObject:movie.movieActors];
    NSData *directorData = [NSKeyedArchiver archivedDataWithRootObject:movie.movieDirectors];
    NSData *genresData = [NSKeyedArchiver archivedDataWithRootObject:movie.genres];
    fmovie.movieActors = actorData;
    
    fmovie.movieDirectors = directorData;
    
    fmovie.genres = genresData;
    
    [self.coreDataManager saveContext];
    
}

- (void)deleteFavoriteMovie:(Movie *)movie {
    NSArray *list = [self getAllFavoriteMovies];
    
    for (FavorieMovies *fmovie in list ) {
        if ([fmovie.movieID isEqualToString:movie.movieID]) {
            [self.coreDataManager.context deleteObject:fmovie];
        }
    }
    [self.coreDataManager saveContext];
}

- (NSArray *)getAllFavoriteMovies {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@""];
    NSArray *fetchObject = [self.coreDataManager.context executeFetchRequest:fetchRequest error:nil];
    return fetchObject;
}






@end
