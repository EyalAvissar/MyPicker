//
//  Utility.m
//  MoviesWithData
//
//  Created by inmanage on 05/12/2021.
//

#import "Utility.h"
#import "MoviesManager.h"

@implementation Utility

+(void)setPresentationStyle:(UIView *)view {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.window.layer addAnimation:transition forKey:kCATransition];
}

+(void)addMenuButton:(UIViewController *)controller {
    UINavigationBar *navigationBar = [[controller navigationController] navigationBar];
    
    float height = navigationBar.bounds.size.height;
    float x = navigationBar.bounds.size.width - 50;
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, controller.view.bounds.size.width, height)];

    UIButton *menuButton =  [UIButton systemButtonWithImage:[UIImage imageNamed:@"person"] target:controller action:@selector(menuButtonTapped)];
    [menuButton setTitle:@"אפשרויות" forState:UIControlStateNormal];
        
    [blueView addSubview:menuButton];
    
    [navigationBar addSubview:blueView];
}

@end
