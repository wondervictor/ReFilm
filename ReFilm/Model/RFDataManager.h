//
//  RFDataManager.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "FavorieMovies.h"


@protocol RFDataManagerDelegate <NSObject>
// Movies NSArray<Movie>
@optional
- (void)didReceiveHotMovieDataWith:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveCommingMovies:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveTopMovies:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveSearchMovies:(NSArray *)movies error:(NSString *)error;

- (void)didReceiveMovieInfo:(Movie *)movies error:(NSString *)error;


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

// Comments and Info
- (void)sendRequestForMovieWithID:(NSString *)movieID;

// Comments
- (void)sendRequestForCommentWithMovieID:(NSString *)movieID;


/// Persistent Store

// addNewFavorite
- (void)addFavoriteMovie:(Movie *)movie;

// deleteFavoriteMovie
- (void)deleteFavoriteMovie:(FavorieMovies *)movie;
// getAllFavoriteMovie
- (NSArray *)getAllFavoriteMovies;

/// 获取缓存图片
- (NSData *)getImageWithID:(NSString *)imageID;
/// 存储缓存图片
- (void)saveImageData:(NSData *)imageData imageID:(NSString *)imageID;
/// 删除所有缓存
- (void)removeAllImageData;


@end


