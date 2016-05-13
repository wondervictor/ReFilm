//
//  RFDataManager.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"


@protocol RFDataManagerDelegate <NSObject>
/// Movies NSArray<Movie>
- (void)didReceiveHotMovieDataWith:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveCommingMovies:(NSArray *)movies error:(NSString *)error;

@end

@interface RFDataManager : NSObject

@property (nonatomic, weak) id<RFDataManagerDelegate> delegate;


+ (RFDataManager *)sharedManager;

/// Hot movies
- (void)sendRequestForHotMovies;

/// Comming Movies
- (void)sendRequestForCommingMovies;

/// Top100
- (void)sendRequestForTop100Movies;

- (void)sendRequestSearchMovieWithName:(NSString *)movieName;


@end


