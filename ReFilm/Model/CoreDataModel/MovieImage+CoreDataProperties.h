//
//  MovieImage+CoreDataProperties.h
//  ReFilm
//
//  Created by VicChan on 5/18/16.
//  Copyright © 2016 VicChan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MovieImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieImage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *imageID;

@end

NS_ASSUME_NONNULL_END
