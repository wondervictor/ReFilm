//
//  RFViewModel.m
//  ReFilm
//
//  Created by VicChan on 5/18/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFViewModel.h"
#import "RFParser.h"
#import "MovieActor.h"
#import "RFDataManager.h"

@implementation RFViewModel

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie {
    cell.movieTitleLabel.text = movie.movieName;
    cell.movieRatingLabel.text = [NSString stringWithFormat:@"%.1f",movie.averageRating];
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    for (MovieActor *actor in movie.movieActors) {
        [actors appendFormat:@" %@",actor.name];
    }
    cell.actorLabel.text = actors;
    if (!movie.movieImage) {
        RFDataManager *manager = [RFDataManager sharedManager];
        NSData *imgData = [manager getImageWithID:movie.movieID];
        if (imgData) {
            cell.movieImage.image = [UIImage imageWithData:imgData];
        } else {
            cell.movieImage.image = [UIImage imageNamed:@"movieImageDefault"];
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
                if (imageData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.movieImage.image = [UIImage imageWithData:imageData];
                        [manager saveImageData:imageData imageID:movie.movieID];
                        
                    });
                }
            });
        }
        // 没有照片

    } else {
        cell.movieImage.image = movie.movieImage;
    }
    
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

- (void)handleTableCell:(MovieTableCell *)cell withMovie:(Movie *)movie {
    cell.movieName.text = movie.movieName;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%.1f",movie.averageRating];
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    for (MovieActor *actor in movie.movieActors) {
        [actors appendFormat:@" %@",actor.name];
    }
    cell.actorsLabel.text = actors;
    if (!movie.movieImage) {
        RFDataManager *manager = [RFDataManager sharedManager];
        NSData *imgData = [manager getImageWithID:movie.movieID];
        if (imgData) {
            cell.movieImage.image = [UIImage imageWithData:imgData];
        } else {
            //cell.movieImage.image = [UIImage imageNamed:@"movieImageDefault"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
                if (imageData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.movieImage.image = [UIImage imageWithData:imageData];
                        [manager saveImageData:imageData imageID:movie.movieID];
                        
                    });
                }
            });
        }
        // 没有照片
        
    } else {
        cell.movieImage.image = movie.movieImage;
    }
    
    NSMutableString *directors = [NSMutableString new];
    [directors appendString:@"导演:"];
    for (MovieActor *director in movie.movieDirectors) {
        [directors appendFormat:@" %@",director.name];
    }
    cell.directorLabel.text = directors;
    
}

- (void)handleTopTableCell:(TopMovieCell *)topCell withMovie:(Movie *)movie {
    topCell.movieTitleLabel.text = movie.title;
    //topCell setMovieImage:
    topCell.yearLabel.text = movie.year;
    NSMutableString *types = [NSMutableString new];
    for (NSString *item in movie.genres) {
        [ types appendFormat:@"%@ ",item];
    }
    
    topCell.typeLabel.text = types;
    
    if (!movie.movieImage) {
        RFDataManager *manager = [RFDataManager sharedManager];
        NSData *imgData = [manager getImageWithID:movie.movieID];
        if (imgData) {
            [topCell setMovieImage:[UIImage imageWithData:imgData]];
        } else {
            //cell.movieImage.image = [UIImage imageNamed:@"movieImageDefault"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
                if (imageData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [topCell setMovieImage:[UIImage imageWithData:imageData]];
                        [manager saveImageData:imageData imageID:movie.movieID];
                        
                    });
                }
            });
        }
        // 没有照片
        
    } else {
        [topCell setMovieImage:movie.movieImage];
    }
    
    
}


- (void)handleMovieActorCell:(ActorCollectionCell *)cell withMovie:(MovieActor *)movie {
    cell.nameLabel.text = movie.name;
    RFDataManager *manager = [RFDataManager sharedManager];
    NSData *imageData = [manager getImageWithID:movie.actorID];
    if (!imageData) {
        cell.imageView.image = [UIImage imageNamed:@"movieImageDefault"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
            if (data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [manager saveImageData:data imageID:movie.actorID];
                    cell.imageView.image = [UIImage imageWithData:data];
                });
            }
        });
    } else {
        cell.imageView.image = [UIImage imageWithData:imageData];
    }
    
}



@end
