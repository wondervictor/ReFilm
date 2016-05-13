//
//  RFDataManager.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MovieTableCell.h"
#import "MovieCollectionCell.h"

@protocol RFDataManagerDelegate <NSObject>
// Movies NSArray<Movie>
@optional
- (void)didReceiveHotMovieDataWith:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveCommingMovies:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveTopMovies:(NSArray *)movies error:(NSString *)error;

@end

@interface RFDataManager : NSObject

@property (nonatomic, weak) id<RFDataManagerDelegate> delegate;


+ (RFDataManager *)sharedManager;

/// Network Request

// Hot movies
- (void)sendRequestForHotMovies;

// Comming Movies
- (void)sendRequestForCommingMovies;

// Top100
- (void)sendRequestForTop100Movies;

// Search
- (void)sendRequestSearchMovieWithName:(NSString *)movieName;


/// Persistent Store

// addNewFavorite
- (void)addFavoriteMovie:(Movie *)movie;

// deleteFavoriteMovie
- (void)deleteFavoriteMovie:(Movie *)movie;

// getAllFavoriteMovie
- (NSArray *)getAllFavoriteMovies;


// ViewModel

- (void)handleTableCell:(MovieTableCell *)cell withMovie:(Movie *)movie;

- (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie;

@end


