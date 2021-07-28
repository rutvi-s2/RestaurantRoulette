//
//  PhotoMapViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import "PhotoMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "APIManager.h"
#import <YelpAPI/YLPClient+Business.h>

@interface PhotoMapViewController ()

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *const camera = [GMSCameraPosition cameraWithLatitude:self.business.location.coordinate.latitude
                                                            longitude:self.business.location.coordinate.longitude
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.mapFrame.frame camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.business.location.coordinate.latitude, self.business.location.coordinate.longitude);
    marker.title = self.business.name;
    marker.map = mapView;
    
    [[APIManager shared] businessWithId:self.business.identifier completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.business = business;
            NSString *allTime = @"";
            NSString *previousDay = @"";
            for(NSDictionary *day in self.business.open){
                NSString *currentDay = [self dayHelper:[day[@"day"] intValue]];
                if([previousDay isEqualToString:currentDay]){
                    previousDay = currentDay;
                    currentDay = @"";
                }else{
                    previousDay = currentDay;
                }
                allTime = [allTime stringByAppendingString:[NSString stringWithFormat:@"%@ - %@ to %@ \n", currentDay , [self timeFormatHelper:day[@"start"]], [self timeFormatHelper:day[@"end"]]]];
            }
            self.hoursLabel.text = allTime;
        });
    }];
}

- (NSString *) timeFormatHelper: (NSString *)timeString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HHmm"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *) dayHelper: (int)day{
    if(day == 0){
        return @"Monday";
    }else if(day == 1){
        return @"Tuesday";
    }else if(day == 2){
        return @"Wednesday";
    }else if(day == 3){
        return @"Thursday";
    }else if(day == 4){
        return @"Friday";
    }else if(day == 5){
        return @"Saturday";
    }else {
        return @"Sunday";
    }
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
