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


@end
