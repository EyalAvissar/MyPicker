//
//  ViewController.m
//  DanceBanana
//
//  Created by inmanage on 20/10/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (IBAction)animationButton:(id)sender {
    
    self.imageView.animationImages = @[[UIImage imageNamed: @"Image1"],
                                       [UIImage imageNamed: @"Image2"],
                                       [UIImage imageNamed: @"Image3"],
                                       [UIImage imageNamed: @"Image4"],
                                       [UIImage imageNamed: @"Image5"],
                                       [UIImage imageNamed: @"Image6"],
                                       [UIImage imageNamed: @"Image7"],
                                       [UIImage imageNamed: @"Image8"]
                                    ];
    
    self.imageView.animationDuration = 1;
    self.imageView.animationRepeatCount = 10;
    [self.imageView startAnimating ];
}
@end
