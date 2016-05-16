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


@interface RFParser : NSObject

+ (Movie *)parserForMovie:(NSDictionary *)data;

+ (NSArray *)parseForSearchMovie:(NSDictionary *)data;

+ (MovieActor *)parseForActor:(NSDictionary *)dict;

+ (NSDictionary *)parserActorIntoDict:(MovieActor *)movieActor;

// ViewModel

+ (void)handleTableCell:(MovieTableCell *)cell withMovie:(FavorieMovies *)movie;

+ (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie;
// test
+ (void)handleCell:(MovieCollectionCell *)cell withMovie:(FavorieMovies *)movie;

+ (NSString *)getURLFromFavoriteMovies:(FavorieMovies *)movie;

@end
