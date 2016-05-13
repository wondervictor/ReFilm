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


@interface RFParser : NSObject

+ (Movie *)parserForMovie:(NSDictionary *)data;

+ (NSArray *)parseForSearchMovie:(NSDictionary *)data;

+ (MovieActor *)parseForActor:(NSDictionary *)dict;

@end
