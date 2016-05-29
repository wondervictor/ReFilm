//
//  RFParser.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFParser.h"


@implementation RFParser


+ (Movie *)parserForMovie:(NSDictionary *)data {
    Movie *movie = [Movie new];
    NSString *subtype = [data valueForKey:@"subtype"];
    if (![subtype isEqualToString:@"movie"]) {
        return nil;
    }
    NSString *alt = [data valueForKey:@"alt"];
    NSLog(@"%@",alt);
    NSArray *casts = [data valueForKey:@"casts"];  // 主演
    NSMutableArray *movieActors = [NSMutableArray new];
    for (NSDictionary *item in casts) {
        MovieActor *actor = [self parseForActor:item];
        if (actor != nil) {
            [movieActors addObject:actor];
        }
    }
    NSInteger collectCount = [[data valueForKey:@"collect_count"] integerValue];
    NSArray *directors = [data valueForKey:@"directors"];  //  导演
    NSMutableArray *movieDirectors = [NSMutableArray new];
    for (NSDictionary *item in directors) {
        MovieActor *director = [self parseForActor:item];
        if (director != nil) {
            [movieDirectors addObject:director];
        }
    }
    NSArray *genres = [data valueForKey:@"genres"];  // 类型
    NSString *movieID = [data valueForKey:@"id"];
    NSDictionary *movieImages = [data valueForKey:@"images"];
    NSString *imageURL = [movieImages valueForKey:@"large"];
    NSString *title = [data valueForKey:@"title"];
    NSString *year = [data valueForKey:@"year"];
    NSDictionary *ratings = [data valueForKey:@"rating"];
    float averageRate = [[ratings valueForKey:@"average"] floatValue];
    
    movie.alt = alt;
    movie.imageURL = imageURL;
    movie.movieID = movieID;
    movie.movieName = title;
    movie.year = year;
    movie.averageRating = averageRate;
    movie.genres = genres;
    movie.movieDirectors = movieDirectors;
    movie.movieActors = movieActors;
    movie.collectCount = collectCount;
    movie.title = title;
    return movie;
}

+ (NSArray *)parseForSearchMovie:(NSDictionary *)data {
    
    NSMutableArray *movieList = [NSMutableArray new];
    NSArray *subjects = [data valueForKey:@"subjects"];
    //NSString *total = [data valueForKey:@"total"];
    
    for (NSDictionary *item in subjects) {
        Movie *movie = [self parserForMovie:item];
        if (movie != nil) {
            [movieList addObject:movie];
        }
    }
    return movieList;
}

+ (MovieActor *)parseForActor:(NSDictionary *)dict {
    NSString *alt = [dict valueForKey:@"alt"];
    NSString *actorID = [dict valueForKey:@"id"];
    NSString *name = [dict valueForKey:@"name"];
    NSDictionary *images = [dict valueForKey:@"avatars"];
    NSString *imageURL = [images valueForKey:@"medium"];
    MovieActor *actor = [MovieActor new];
    actor.actorID = actorID;
    actor.name = name;
    actor.imageURL = imageURL;
    actor.actorInfo = alt;
    return actor;
}



+ (NSDictionary *)parserActorIntoDict:(MovieActor *)movieActor {
    NSArray *values = [[NSArray alloc]initWithObjects:movieActor.name,movieActor.imageURL,movieActor.actorID,movieActor.actorInfo, nil];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:values forKeys:@[@"name",@"image",@"id",@"actorinfo"]];
    return dict;
}

+ (MovieActor *)parseDictIntoMovieActor:(NSDictionary *)dict {
    MovieActor *movieActor = [MovieActor new];
    movieActor.name = [dict valueForKey:@"name"];
    movieActor.imageURL = [dict valueForKey:@"image"];
    movieActor.actorInfo = [dict valueForKey:@"actorinfo"];
    movieActor.actorID = [dict valueForKey:@"id"];
    return movieActor;
}


+ (NSString *)getURLFromFavoriteMovies:(FavorieMovies *)movie {
    return movie.alt;
}

+ (MovieDetail *)parseForMovieDetail:(NSDictionary *)data {
    MovieDetail *detail = [MovieDetail new];
    detail.alt = [data valueForKey:@"alt"];
    NSDictionary *attr = [data valueForKey:@"attrs"];
    
    NSArray *countries = [attr valueForKey:@"country"];
    NSMutableString *country = [NSMutableString new];
    for (NSString *item in countries) {
        [country appendFormat:@"%@ ",item];
    }
    detail.country = country;
    
    NSMutableString *language = [NSMutableString new];
    for (NSString *item in [attr valueForKey:@"language"]) {
        [language appendFormat:@"%@ ",item];
    }
    detail.movieLanguage = language;
    
    detail.movieDuration = [[attr valueForKey:@"movie_duration"]firstObject];
    
    detail.pubdate = [attr valueForKey:@"pubdate"];
    
    /*
    NSMutableString *movieType = [NSMutableString new];
    for (NSString *item in [attr valueForKey:@"movie_type"]) {
        [movieType appendFormat:@"%@ ",movieType];
    }
     */
    
    
    detail.genres = [attr valueForKey:@"movie_type"];
    
    detail.year = [[attr valueForKey:@"year"]firstObject];
    
    detail.movieWebSite = [[attr valueForKey:@"website"]firstObject];
    
    detail.summary = [data valueForKey:@"summary"];
    
    return detail;
}


+ (Movie *)convertFavoriteMovie:(FavorieMovies *)movie {
    Movie *aMovie = [Movie new];
    aMovie.movieName = movie.movieName;
    aMovie.movieID = movie.movieID;
    aMovie.alt = movie.alt;
    aMovie.averageRating = movie.averageRating.floatValue;
    aMovie.year = movie.year;
    aMovie.movieImage = [UIImage imageWithData:movie.movieImage];
    aMovie.imageURL = movie.imageURL;
    NSArray *movieActors = [NSKeyedUnarchiver unarchiveObjectWithData:movie.movieActors];
    NSMutableArray *actors = [NSMutableArray new];
    
    for (NSDictionary *dict in movieActors) {
        MovieActor *actor = [self parseForActor:dict];
        [actors addObject:actor];
    }
    aMovie.movieActors = actors;
    
    NSArray *movirDirectors = [NSKeyedUnarchiver unarchiveObjectWithData:movie.movieDirectors];
    NSMutableArray *directors = [NSMutableArray new];
    
    for (NSDictionary *dict in movirDirectors) {
        MovieActor *director = [self parseForActor:dict];
        [directors addObject:director];
    }
    aMovie.movieDirectors = directors;
    
    aMovie.genres = [NSKeyedUnarchiver unarchiveObjectWithData:movie.genres];
    
    return aMovie;
}


@end
