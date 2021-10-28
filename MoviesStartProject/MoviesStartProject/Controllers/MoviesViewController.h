//
//  MoviesViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *moviesTable;

@end

NS_ASSUME_NONNULL_END
