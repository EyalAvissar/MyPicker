//
//  ViewController.m
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import "MapController.h"
#import "Cinema.h"
#import "ApplicationManager.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "Utility.h"
#import "MoviesViewController.h"
#import "NewCinemaViewController.h"

@interface MapController ()

@end

@implementation MapController

//MARK: LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    [Utility addMenuButton:self];    
}


- (void)viewWillAppear:(BOOL)animated {
    CLLocationCoordinate2D location;

    for (NSString *cinemaID in self.locations) {
        Cinema *cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:[NSString stringWithFormat:@"%@",cinemaID]];
        
        location.latitude = [cinema.latitudeStr doubleValue];
        location.longitude = [cinema.longitudeStr doubleValue];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:location];
        
        annotation.title = cinema.name;
        [self.mapView addAnnotation:annotation];
    }
}

- (void)setAnnotationView:(MKAnnotationView *)annotationView {
    annotationView.canShowCallout = true;
    annotationView.enabled = true;
    annotationView.frame = CGRectMake(0, 0, 10, 10);
    annotationView.backgroundColor = [UIColor greenColor];
    
    UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = disclosureButton;
    annotationView.image = [UIImage systemImageNamed:@"person"];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"custom"];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"custom"];
        
        [self setAnnotationView:annotationView];
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"Annotation tapped");
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Annotation button tapped");
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
        
    detailController.movieId = self.movie.movieId;
    
    [self.navigationController pushViewController:detailController animated:true];
}

-(void)menuButtonTapped {
    MenuViewController *menuController = [[ApplicationManager sharedInstance].movieManager menu];

    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [Utility setPresentationStyle:self.view];

    [self presentViewController:menuController animated:true completion:nil];
}

- (void)didPressNumber:(long)pressed {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"pressed %lu", pressed);
    if (pressed == 0) {
        MoviesViewController *moviesVC = [storyBoard instantiateViewControllerWithIdentifier:@"Movies"];
        [[self navigationController] pushViewController:moviesVC animated:true];
    }
    
    if (pressed == 1) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NewCinemaViewController *testVC = [storyBoard instantiateViewControllerWithIdentifier:@"Cinemas"];
        [[self navigationController] pushViewController:testVC animated:true];
    }
}

@end
