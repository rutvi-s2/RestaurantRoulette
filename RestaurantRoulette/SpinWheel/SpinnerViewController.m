//
//  SpinnerViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import "SpinnerViewController.h"
#import "SpinnerWheel.h"
#import <Parse/Parse.h>
#import "DetailsViewController.h"

@interface SpinnerViewController ()

@end

@implementation SpinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.bounds.size.width/2 - 15, self.view.bounds.size.height/2 - 15, 30, 30)] CGPath]];
    
    SpinnerWheel *wheel = [[SpinnerWheel alloc]initWithFrame:CGRectMake(0,0,370,700) andDelegate:self withWedges:(int)self.spinnerItems.count withItems:self.spinnerItems];
    wheel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    //add wheel to current view
    [self.view addSubview:wheel];
    [[self.view layer] addSublayer:circleLayer];
}

- (void) alertBusiness:(YLPBusiness *)business{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Chosen" message:[NSString stringWithFormat:@"You have chosen %@", business.name] preferredStyle:UIAlertControllerStyleAlert];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Spin Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.view.subviews setValue:@YES forKeyPath:@"hidden"];
        self.background.hidden = NO;
        self.yellowArrow.hidden = NO;
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.bounds.size.width/2 - 15, self.view.bounds.size.height/2 - 15, 30, 30)] CGPath]];
        
        SpinnerWheel *wheel = [[SpinnerWheel alloc]initWithFrame:CGRectMake(0,0,370,700) andDelegate:self withWedges:(int)self.spinnerItems.count withItems:self.spinnerItems];
        wheel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        //add wheel to current view
        [self.view addSubview:wheel];
        [[self.view layer] addSublayer:circleLayer];
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController  *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewNavigationController"];
        DetailsViewController *detailsViewController = (DetailsViewController *)navigationController.topViewController;
        detailsViewController.business = business;
        detailsViewController.finalView = true;
        [self parseHelper:business];
        [self presentViewController:navigationController animated:YES completion:^{}];
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void) parseHelper : (YLPBusiness *)business{
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query includeKey: @"username"];
    [query whereKey:@"username" equalTo:PFUser.currentUser.username];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *profiles, NSError *error){
        if(profiles != nil){
            self.profile = profiles.firstObject;
            if(self.profile.currentBookingsArray == nil){
                self.profile.currentBookingsArray= [NSMutableArray new];
            }
            [self.profile.currentBookingsArray addObject:business.identifier];
            self.profile [@"currentBookingsArray"] = self.profile.currentBookingsArray;
            
            if(self.profile.timeOfBooking == nil){
                self.profile.timeOfBooking= [NSMutableArray new];
            }
            [self.profile.timeOfBooking addObject:self.timeTracker];
            self.profile [@"timeOfBooking"] = self.profile.timeOfBooking;
            
            [self.profile saveInBackground];
        }else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
