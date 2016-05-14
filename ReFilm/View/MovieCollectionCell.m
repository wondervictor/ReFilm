//
//  MovieCollectionCell.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "MovieCollectionCell.h"
#import <Masonry.h>

@interface MovieCollectionCell()
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation MovieCollectionCell

- (id)init {
    if (self = [super init]) {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressedCell:)];
    }
    return self;
}

- (void)configureSubViews {
    
}

- (void)longPressedCell:(UILongPressGestureRecognizer *)recognizer {
    
}




@end
