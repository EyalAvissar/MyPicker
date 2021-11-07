//
//  DetailViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import <Webkit/Webkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet WKWebView *promoWebView;
@property (weak, nonatomic) IBOutlet UIButton *promoURL;

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
- (IBAction)showPromo:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
