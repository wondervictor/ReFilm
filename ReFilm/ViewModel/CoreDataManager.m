//
//  CoreDataManager.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "CoreDataManager.h"


@implementation CoreDataManager

static NSString *storeFileName = @"movie.sqlite";

- (NSURL *)storeURL {
    // Directory Path
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    // Create File
    NSURL *storeDirectory = [[NSURL fileURLWithPath:documentDirectory]URLByAppendingPathComponent:@"store"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[storeDirectory path]]) {
        NSError *error = nil;
        if ([manager createDirectoryAtURL:storeDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            NSLog(@"successfully created stores directory");
        
            
        }
        else {
            NSLog(@"failed to create stores error :%@",error);
        }
    }
    return [storeDirectory URLByAppendingPathComponent:storeFileName];
    
}


- (id)init {
    
    if (self = [super init]) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:_coordinator];
    }
    
    return self;
}

- (void)loadStore {
    if (_store) {
        return;
    }
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
    if (!_store) {
        NSLog(@"failed to build");
    }
    else {
        NSLog(@"success add store ");
    }

}

- (void)setStore {
    [self loadStore];
}

- (void)saveContext {
    
    if ([self.context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"saved to context");
        }
        else {
            NSLog(@"failed to save to context %@ ",error);
        }
    }
    else {
        NSLog(@"skipped ");
    }

}

- (void)getPath {
    NSLog(@"%@",[self storeURL]);
}


@end
