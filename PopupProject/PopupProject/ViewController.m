//
//  ViewController.m
//  PopupProject
//
//  Created by inmanage on 02/12/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

static NSString *identifier = @"Cell";

@implementation ViewController{
    UITableView *popupView;
    NSArray *optionsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    optionsArray = @[@"Red Color", @"Blue Color", @"Default"];
}




- (IBAction)showPopup:(id)sender {
    UIButton *button = (UIButton *) sender;
    float width = arc4random_uniform(400);
    float height = arc4random_uniform(400);
    
    float x = button.frame.origin.x;
    float y = button.frame.origin.y;
    
    if ((y + height) > self.view.bounds.size.height - 50) {
        y = y - height - 10;
    }
    
    width = width < 200 ? 200 : width;
    height = height < 200 ? 200 : height;
    
    if (popupView) {
        [popupView removeFromSuperview];
    }
    
    popupView = [[UITableView alloc] initWithFrame: CGRectMake(x, y, width, height)];
    [popupView registerClass:[UITableViewCell class] forCellReuseIdentifier: identifier];
    popupView.backgroundColor = [UIColor yellowColor];
    popupView.delegate = self;
    popupView.dataSource = self;
    
    [self.view addSubview:popupView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = optionsArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return optionsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.view.backgroundColor = [UIColor redColor];
            break;
        
        case 1:
            self.view.backgroundColor = [UIColor blueColor];
            break;
            
        default:
            self.view.backgroundColor = [UIColor purpleColor];
            break;
    }
    
    [popupView setHidden:true];
    [popupView removeFromSuperview];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return popupView.frame.size.height / 3;
}
@end
