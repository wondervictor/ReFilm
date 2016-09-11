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
#import "MovieImage.h"

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

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)sendRequestForHotMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/in_theaters";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveHotMovieDataWith:movies error:nil];
    } failure:^(NSError *error, NSString *errorMsg) {
        [_delegate didReceiveHotMovieDataWith:nil error:@"网络故障"];
    }];
}

- (void)sendRequestForCommingMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/coming_soon";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveCommingMovies:movies error:nil];
    } failure:^(NSError *error, NSString *errorMsg) {
        [_delegate didReceiveCommingMovies:nil error:@"网络故障"];
    }];
}

- (void)sendRequestForTop100Movies {
    NSString *urlString = @"http://api.douban.com/v2/movie/top250";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *movies = [RFParser parseForSearchMovie:responseObject];
        [_delegate didReceiveTopMovies:movies error:nil];
    } failure:^(NSError *error, NSString *errorMsg) {

        [_delegate didReceiveTopMovies:nil error:@"网络故障"];
    }];
}

- (void)sendRequestSearchMovieWithName:(NSString *)movieName {
    NSString *url = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/search?q=%@",movieName];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSArray *array = [RFParser parseForSearchMovie:responseObject];
        //Movie *movie = [array firstObject];
        [_delegate didReceiveSearchMovies:array error:nil];
        
    } failure:^(NSError *error, NSString *errorMsg) {
        [_delegate didReceiveSearchMovies:nil error:@"网络故障"];
    }];

}

- (void)sendRequestForMovieWithID:(NSString *)movieID {
    NSString *url = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/%@",movieID];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        //NSLog(@"movie info----%@",responseObject);
        MovieDetail *detail = [RFParser parseForMovieDetail:responseObject];
        [_delegate didReceiveMovieInfo:detail error:nil];
        NSLog(@"%@",responseObject);
        //_delegate didReceiveMovieInfo: error:<#(NSString *)#>
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"eerror");
        [_delegate didReceiveMovieInfo:nil error:@"网络故障"];
    }];
}

- (void)sendRequestForCommentWithMovieID:(NSString *)movieID {
    NSString *url = [NSString stringWithFormat:@"http://123.206.42.134/refilm/find_movie.php?id=%@",movieID];
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:url success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"%@",responseObject);
        NSArray *result = [RFParser parseForCommentWithDict:responseObject];
        [_delegate didReceiveComments:result error:nil];
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];

}


#pragma mark - Perisistent Store
#pragma mark - FavoriteMovie
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
    if (!fmovie.movieImage) {
        fmovie.movieImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    }
    
    fmovie.imageURL = movie.imageURL;
    
    
    NSMutableArray *actors = [NSMutableArray new];
    for (MovieActor *actor in movie.movieActors) {
        NSDictionary *dict = [RFParser parserActorIntoDict:actor];
        [actors addObject:dict];
    }

    NSMutableArray *directors = [NSMutableArray new];
    for (MovieActor *director in movie.movieDirectors) {
        NSDictionary *dict = [RFParser parserActorIntoDict:director];
        [directors addObject:dict];
    }
    
    
    NSData *actorData = [NSKeyedArchiver archivedDataWithRootObject:actors];
    NSData *directorData = [NSKeyedArchiver archivedDataWithRootObject:directors];
    NSData *genresData = [NSKeyedArchiver archivedDataWithRootObject:movie.genres];
    fmovie.movieActors = actorData;
    fmovie.movieDirectors = directorData;
    fmovie.genres = genresData;
    
    [self.coreDataManager saveContext];
    
}

- (void)deleteFavoriteMovie:(FavorieMovies *)movie {
    NSArray *list = [self getAllFavoriteMovies];
    
    for (FavorieMovies *fmovie in list ) {
        if ([fmovie.movieID isEqualToString:movie.movieID]) {
            [self.coreDataManager.context deleteObject:fmovie];
        }
    }
    [self.coreDataManager saveContext];
}

- (NSArray *)getAllFavoriteMovies {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMovies"];
    NSArray *fetchObject = [self.coreDataManager.context executeFetchRequest:fetchRequest error:nil];
    return fetchObject;
}

#pragma mark - ImageData
- (void)saveImageData:(NSData *)imageData imageID:(NSString *)imageID {
    MovieImage *movieImage = [NSEntityDescription insertNewObjectForEntityForName:@"MovieImage" inManagedObjectContext:self.coreDataManager.context];
    movieImage.image = imageData;
    movieImage.imageID = imageID;
    [self.coreDataManager saveContext];
}

- (NSData *)getImageWithID:(NSString *)imageID {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"MovieImage"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageID=%@",imageID];
    [request setPredicate:predicate];
    NSArray *fetchObject = [self.coreDataManager.context executeFetchRequest:request error:nil];
    if (fetchObject.count != 0) {
        MovieImage *image = fetchObject.lastObject;
        return image.image;
    } else {
        return nil;
    }
    
}

- (void)removeAllImageData {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"MovieImage"];
    NSArray *fetchObjects = [self.coreDataManager.context executeFetchRequest:request error:nil];
    for (MovieImage *item in fetchObjects) {
        [self.coreDataManager.context deleteObject:item];
    }
    [self.coreDataManager saveContext];

}



@end
