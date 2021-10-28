//
//  MoviesViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesViewController.h"

static NSString *identifier;

@interface MoviesViewController ()
{
    NSArray *array;
}
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = @[@1, @2, @3, @4];
    identifier = @"movieCell";
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array count];
}


@end
