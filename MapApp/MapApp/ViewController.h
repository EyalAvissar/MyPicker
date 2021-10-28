//
//  ViewController.h
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import "MapPin.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)standard:(id)sender;
- (IBAction)satelite:(id)sender;
- (IBAction)hybrid:(id)sender;
- (IBAction)locate:(id)sender;
- (IBAction)directions:(id)sender;


@end

