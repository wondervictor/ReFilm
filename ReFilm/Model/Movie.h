//
//  Movie.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Movie : NSObject
/// 电影ID
@property (nonatomic, copy) NSString *movieID;
/// 电影名称
@property (nonatomic, copy) NSString *movieName;
/// 演员表
@property (nonatomic, strong) NSArray *movieActors;
/// 导演
@property (nonatomic, strong) NSArray *movieDirectors;
/// 年份
@property (nonatomic, copy) NSString *year;
/// 平均评分
@property (nonatomic, assign) float averageRating;
/// 风图URL
@property (nonatomic, copy) NSString *imageURL;
/// 影片类型
@property (nonatomic, strong) NSArray *genres;
/// 标题（中文）
@property (nonatomic, copy) NSString *title;
/// 条目URL
@property (nonatomic, strong) NSString *alt;

@property (nonatomic, assign) NSInteger collectCount;

@end
