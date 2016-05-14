//
//  FavoriteController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "FavoriteController.h"
#import "MovieTableCell.h"
#import "RFDataManager.h"
#import "RFParser.h"
#import "MovieActor.h"
#import "Movie.h"
#import "CoreDataManager.h"

#define MAIN_HEIGHT   (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface FavoriteController()<UITableViewDelegate,UITableViewDataSource,RFDataManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movies;

@end



@implementation FavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.movies = [NSMutableArray new];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-113) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self getFavoriteMovieData];
    CoreDataManager *manager = [CoreDataManager new];
    [manager getPath];
    
    //[self test];
    
}

- (void)getFavoriteMovieData {
    RFDataManager *manager = [RFDataManager sharedManager];
    [self.movies removeAllObjects];
    [self.movies addObjectsFromArray:[manager getAllFavoriteMovies]];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource || UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MovieCell";
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MovieTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    /*
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    cell.movieName.text = movie.movieName;
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:movie.imageURL]];
    UIImage *image = [UIImage imageWithData:imageData scale:1];
    cell.movieImage.image = image;
    
    NSMutableString *directors = [NSMutableString new];
    [directors appendString:@"导演:"];
    NSMutableString *actors = [NSMutableString new];
    [actors appendString:@"演员:"];
    for (MovieActor *actor in movie.movieActors) {
        [actors appendFormat:@" %@",actor.name];
    }
    for (MovieActor *director in movie.movieDirectors) {
        [directors appendFormat:@" %@",director.name];
    }
    cell.actorsLabel.text = actors;
    cell.directorLabel.text = directors;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%f",movie.averageRating];
*/
    [RFParser handleTableCell:cell withMovie:[self.movies objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Detail Controller
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.movies count] == 0) {
            return;
        }
        else {
            RFDataManager *manager = [RFDataManager sharedManager];
            [manager deleteFavoriteMovie:[self.movies objectAtIndex:indexPath.row]];
            [self.movies removeObject:[self.movies objectAtIndex:indexPath.row]];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


#pragma mark - Test
- (void)test {
    RFDataManager *manager = [RFDataManager sharedManager];
    [manager sendRequestForHotMovies];
    manager.delegate = self;
}

#pragma mark - RFDataManagerDelegate

- (void)didReceiveHotMovieDataWith:(NSArray *)movies error:(NSString *)error {
    if (error) {
        NSLog(@"error");
    }
    else {
        NSLog(@"%lur",[movies count]);
        //RFDataManager *manager = [RFDataManager sharedManager];
        
        [self.movies removeAllObjects];
        [self.movies addObjectsFromArray:movies];
        [self.tableView reloadData];
    }
}


@end
