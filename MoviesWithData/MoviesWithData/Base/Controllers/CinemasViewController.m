//
//  CinemasViewController.m
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import "CinemasViewController.h"
#import "MoviesViewController.h"
#import "MoviesManager.h"
#import "ApplicationManager.h"
#import "Cinema.h"
#import "CinemaTableCell.h"
#import "DetailViewController.h"
#import "Utility.h"

@interface CinemasViewController ()

@end

@implementation CinemasViewController
{
    MenuViewController *menuController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cinemasTable registerNib:[UINib nibWithNibName:@"CinemaTableCell" bundle:nil] forCellReuseIdentifier:[CinemaTableCell identifier]];
    
    [Utility addMenuButton:self];
}

- (void)didPressNumber:(long)pressed {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"pressed %lu", pressed);
    if (pressed == 0) {
        MoviesViewController *moviesVC = [storyBoard instantiateViewControllerWithIdentifier:@"Movies"];
        [[self navigationController] pushViewController:moviesVC animated:true];
    }
}

- (void)didPressMovie:(long)pressed :(NSString *)at {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
    
    detailController.movieId = [NSString stringWithFormat:@"%li", (long)pressed];
    
    detailController.cinemaId = at;
    
    [self.navigationController pushViewController:detailController animated:true];
}


-(void)menuButtonTapped {    
    menuController = [[ApplicationManager sharedInstance].movieManager menu];

    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [Utility setPresentationStyle:self.view];

    [self presentViewController:menuController animated:true completion:nil];
}

#pragma mark- TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell" forIndexPath:indexPath];
    
    cell.dataSource = self;
    
    [cell configureCell:indexPath.row];
    
    return cell;
}

@end
