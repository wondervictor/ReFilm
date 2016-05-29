//
//  RFParser.h
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MovieActor.h"
#import "MovieTableCell.h"
#import "MovieCollectionCell.h"
#import "FavorieMovies.h"
#import "MovieDetail.h"


@interface RFParser : NSObject

+ (Movie *)parserForMovie:(NSDictionary *)data;

+ (NSArray *)parseForSearchMovie:(NSDictionary *)data;

+ (MovieActor *)parseForActor:(NSDictionary *)dict;

+ (NSDictionary *)parserActorIntoDict:(MovieActor *)movieActor;

+ (MovieActor *)parseDictIntoMovieActor:(NSDictionary *)dict;


+ (NSString *)getURLFromFavoriteMovies:(FavorieMovies *)movie;

+ (MovieDetail *)parseForMovieDetail:(NSDictionary *)data;

+ (Movie *)convertFavoriteMovie:(FavorieMovies *)movie;


@end
