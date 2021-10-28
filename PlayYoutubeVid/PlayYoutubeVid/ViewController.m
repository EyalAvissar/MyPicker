//
//  ViewController.m
//  PlayYoutubeVid
//
//  Created by inmanage on 21/10/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadHTMLString:@"<iframe width=\"1024\" height=\"760\" src=\"https://www.youtube.com/embed/XBFEXqg1uao\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>" baseURL:nil];
}


@end
