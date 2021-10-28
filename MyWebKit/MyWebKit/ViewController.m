//
//  ViewController.m
//  MyWebKit
//
//  Created by inmanage on 20/10/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]]];
    
    [self.webView addSubview: self.activityIndicator];
    self.webView.navigationDelegate = self;
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.activityIndicator stopAnimating];
}

- (IBAction)forward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (IBAction)back:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)stop:(id)sender {
    [self.webView stopLoading];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",self.searchBar.text]]]];
    [searchBar resignFirstResponder];

}
@end
