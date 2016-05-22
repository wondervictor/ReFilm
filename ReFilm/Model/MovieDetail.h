//
//  MovieDetail.h
//  ReFilm
//
//  Created by VicChan on 5/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieDetail : NSObject

/// 电影ID
@property (nonatomic, copy) NSString *movieID;

/// 电影名称
@property (nonatomic, copy) NSString *movieName;

/// 地区
@property (nonatomic, copy) NSString *country;

/// 年份
@property (nonatomic, copy) NSString *year;

/// 平均评分
@property (nonatomic, assign) float averageRating;

/// 风图URL
@property (nonatomic, copy) NSString *imageURL;

/// 影片类型
@property (nonatomic, strong) NSArray *genres;

/// 条目URL
@property (nonatomic, copy) NSString *alt;

/// summary
@property (nonatomic, copy) NSString *summary;

/// 电影网站
@property (nonatomic, copy) NSString *movieWebSite;

/// 电影作者
@property (nonatomic, copy) NSString *writer;

/// 电影发布日期
@property (nonatomic, strong) NSArray *pubdate;

/// 电影时长
@property (nonatomic, copy) NSString *movieDuration;

/// 电影语言
@property (nonatomic, copy) NSString *movieLanguage;



@end
