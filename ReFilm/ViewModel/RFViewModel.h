//
//  RFViewModel.h
//  ReFilm
//
//  Created by VicChan on 5/18/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "MovieCollectionCell.h"
#import "MovieTableCell.h"
#import "Movie.h"
#import "MovieActor.h"
#import "TopMovieCell.h"
#import "FavorieMovies.h"
#import "ReFilm-Swift.h"
#import "MovieComment.h"


@interface RFViewModel : NSObject


// MARK: 处理Movie的Model
- (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie;


// MARK: 处理FavoriteMovie的Model
- (void)handleTableCell:(MovieTableCell *)cell withFavoriteMovies:(FavorieMovies *)movie;

// MARK: 测试使用－－－ 处理CollectionView的 FavoriteMovie

- (void)handleCollectionCell:(MovieCollectionCell *)cell withFavoriteMovies:(FavorieMovies *)movie;
// MARK: 处理TableView的 Movie model
- (void)handleTableCell:(MovieTableCell *)cell withMovie:(Movie *)movie;
// MARK: 处理top100 movie
- (void)handleTopTableCell:(TopMovieCell *)topCell withMovie:(Movie *)movie;
// MARK: Movie Actor Cell View Model
- (void)handleMovieActorCell:(ActorCollectionCell *)cell withMovie:(MovieActor *)actor;
// MARK:处理正在上映电影
- (void)handleComingCell:(ComingMovieViewCell *)cell withMovie:(Movie *)movie;
// MARK:
- (void)handleCommentCell:(CommentCell *)cell withComment:(MovieComment *)comment;


@end
