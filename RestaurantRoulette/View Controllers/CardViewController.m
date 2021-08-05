//
//  CardViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/29/21.
//

#import "CardViewController.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "APIManager.h"
#import <YelpAPI/YLPCoordinate.h>
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPCategory.h>
#import <YelpAPI/YLPBusiness.h>
#import "UIImageView+AFNetworking.h"
#import "RestaurantsViewController.h"
#import "LoginViewController.h"

@interface CardViewController () <MDCSwipeToChooseDelegate>

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideLabels];
    self.keepBusinesses = [NSMutableArray new];
    self.keepBusinessesTracker = [NSMutableArray new];
}
- (IBAction)logoutPress:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *LoginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:LoginViewController animated:YES completion:^{
        }];
    }];
}

- (IBAction)goPressed:(id)sender {
    self.goButton.hidden = YES;
    self.location.hidden = YES;
    self.queryControl.hidden = YES;
    
    int const meter_conversion = 1600;
    NSArray const *queries = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",nil];
    [[APIManager shared] searchWithLocation:self.location.text term:@"restaurants" limit:[queries[self.queryControl.selectedSegmentIndex] integerValue] offset:0 sort:YLPSortTypeHighestRated radiusFilter: ((5 + arc4random_uniform(20)))*meter_conversion openNow:true completionHandler:^
     (YLPSearch *search, NSError *error){
        self.search = search;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.search.businesses.count == 0){
                self.continueButton.hidden = NO;
                [self alertHelper:@"No restaurants available!"];
            }else{
                for(YLPBusiness *business in self.search.businesses){
                    [self.keepBusinessesTracker addObject:business];
                    [self cardSwiper:business.imageURL];
                }
                self.continueButton.hidden = NO;
            }
        });
    }];
}

- (IBAction)updateTextPosition:(id)sender {
    if(self.location.text.length == 0){
        [self hideLabels];
    }else if (self.goButton.isHidden){
        [self showLabels];
    }
}

-(void)hideLabels{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect locationFrame = self.location.frame;
        locationFrame.origin.y += 200;
        self.location.frame = locationFrame;
        
        self.goButton.hidden = YES;
        self.queryControl.hidden = YES;
        self.continueButton.hidden = YES;
    }];
}
-(void)showLabels{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect locationFrame = self.location.frame;
        locationFrame.origin.y -= 200;
        
        self.location.frame = locationFrame;
        self.goButton.hidden = NO;
        self.queryControl.hidden = NO;
    }];
}


- (void) cardSwiper: (NSURL *) url{
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"YUM";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"NAH";
    options.onPan = ^(MDCPanState *state){};

    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:CGRectMake(50, 200, 300, 400) options:options];
    [view.imageView setImageWithURL:url];
    [self.view addSubview:view];
}

- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
        [self.keepBusinessesTracker removeObjectAtIndex:(self.keepBusinessesTracker.count - 1)];
    } else {
        NSLog(@"Photo saved!");
        YLPBusiness *addBusiness = [self.keepBusinessesTracker objectAtIndex:(self.keepBusinessesTracker.count - 1)];
        [self.keepBusinesses addObject:addBusiness];
        [self.keepBusinessesTracker removeObjectAtIndex:(self.keepBusinessesTracker.count - 1)];
    }
}

- (void) alertHelper : (NSString *)warning{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message: warning preferredStyle:UIAlertControllerStyleAlert];
    // create a cancel action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
    // add the cancel action to the alertController
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.search.businesses = self.keepBusinesses;
    self.search.total = self.keepBusinesses.count;
    UINavigationController  *navigationController = [segue destinationViewController];
    RestaurantsViewController  *restaurantController = (RestaurantsViewController*)navigationController.topViewController;
    restaurantController.nonfavoriteTab = true;
    restaurantController.card = true;
    restaurantController.cardSearch = self.search;
    NSDate *date = [NSDate date];
    NSString *finalTime = [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970]];
    restaurantController.timeTracker = finalTime;
    restaurantController.time = [finalTime integerValue];
}

@end
