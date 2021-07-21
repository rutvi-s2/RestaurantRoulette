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
    //TODO: change the withWedges param to count of restaurants selected
    SpinnerWheel *wheel = [[SpinnerWheel alloc]initWithFrame:CGRectMake(0,0,370,700) andDelegate:self withWedges:8];
    
    //add wheel to current view
    [self.view addSubview:wheel];
    
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
