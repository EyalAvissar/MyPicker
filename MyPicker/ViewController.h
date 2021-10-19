//
//  ViewController.h
//  MyPicker
//
//  Created by inmanage on 19/10/2021.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *array;
}

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

