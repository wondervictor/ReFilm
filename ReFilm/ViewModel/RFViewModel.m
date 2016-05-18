//
//  RFViewModel.m
//  ReFilm
//
//  Created by VicChan on 5/18/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFViewModel.h"
#import "RFParser.h"


@implementation RFViewModel

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie {
    
}

- (void)handleTableCell:(MovieTableCell *)cell withFavoriteMovies:(FavorieMovies *)movie {
    cell.movieName.text = movie.movieName;
    NSData *imageData = movie.movieImage; //[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    UIImage *image = [UIImage imageWithData:imageData scale:1];
    cell.movieImage.image = image;
    
    NSMutableString *directors = [NSMutableString new];
    [directors appendString:@"导演:"];
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    /*
     for (MovieActor *actor in movie.movieActors) {
     [actors appendFormat:@" %@",actor.name];
     }
     for (MovieActor *director in movie.movieDirectors) {
     [directors appendFormat:@" %@",director.name];
     }
     */
    NSArray *movieActors = [NSKeyedUnarchiver unarchiveObjectWithData:movie.movieActors];
    for (NSDictionary *item in movieActors) {
        MovieActor *actor = [RFParser parseDictIntoMovieActor:item];
        [actors appendFormat:@" %@",actor.name];
    }
    NSArray *movieDirectors = [NSKeyedUnarchiver unarchiveObjectWithData:movie.movieDirectors];
    for (NSDictionary *item in movieDirectors) {
        MovieActor *director = [RFParser parseDictIntoMovieActor:item];
        [directors appendFormat:@" %@",director.name];
    }
    
    
    cell.actorsLabel.text = actors;
    cell.directorLabel.text = directors;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%.1f",[movie.averageRating floatValue]];
}


#pragma mark - Only For Test
- (void)handleCollectionCell:(MovieCollectionCell *)cell withFavoriteMovies:(FavorieMovies *)movie {
    cell.movieTitleLabel.text = movie.movieName;
    NSData *imageData = movie.movieImage; //[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    UIImage *image = [UIImage imageWithData:imageData scale:1];
    cell.movieImage.image = image;
    
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    NSArray *movieActors = [NSKeyedUnarchiver unarchiveObjectWithData:movie.movieActors];
    for (NSDictionary *item in movieActors) {
        MovieActor *actor = [RFParser parseDictIntoMovieActor:item];
        [actors appendFormat:@" %@",actor.name];
    }
    cell.actorLabel.text = actors;
    cell.movieRatingLabel.text = [NSString stringWithFormat:@"%.1f",[movie.averageRating floatValue]];

}








@end