//
//  FavorieMovies+CoreDataProperties.h
//  ReFilm
//
//  Created by VicChan on 5/14/16.
//  Copyright © 2016 VicChan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FavorieMovies.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavorieMovies (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *movieID;
@property (nullable, nonatomic, retain) NSString *movieName;
@property (nullable, nonatomic, retain) NSData *movieActors;
@property (nullable, nonatomic, retain) NSString *year;
@property (nullable, nonatomic, retain) NSNumber *averageRating;
@property (nullable, nonatomic, retain) NSString *alt;
@property (nullable, nonatomic, retain) NSData *genres;
@property (nullable, nonatomic, retain) NSData *movieImage;
@property (nullable, nonatomic, retain) NSData *movieDirectors;
@property (nullable, nonatomic, retain) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
