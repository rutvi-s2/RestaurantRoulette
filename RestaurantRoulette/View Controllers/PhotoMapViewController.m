//
//  PhotoMapViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import "PhotoMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PhotoMapViewController ()

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.business.location.coordinate.latitude
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
