//
//  SpinnerViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import "SpinnerViewController.h"
#import "SpinnerWheel.h"

@interface SpinnerViewController ()

@end

@implementation SpinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 50, 50)] CGPath]];
    
    CAShapeLayer *outerCircleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 50, 50)] CGPath]];
    
    SpinnerWheel *wheel = [[SpinnerWheel alloc]initWithFrame:CGRectMake(0,0,370,700) andDelegate:self withWedges:(int)self.spinnerItems.count withItems:self.spinnerItems];
    wheel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    //add wheel to current view
    [self.view addSubview:wheel];
    [[self.view layer] addSublayer:circleLayer];
}

- (void) wheelValueChanged:(NSString *)newValue{
    self.sectorLabel.text = newValue;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
