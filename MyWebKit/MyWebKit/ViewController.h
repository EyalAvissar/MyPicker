//
//  ViewController.h
//  MyWebKit
//
//  Created by inmanage on 20/10/2021.
//

#import <UIKit/UIKit.h>
#import <WebKit/Webkit.h>

@interface ViewController : UIViewController <WKNavigationDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)stop:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;

@end

