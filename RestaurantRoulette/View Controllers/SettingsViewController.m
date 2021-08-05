//
//  SettingsViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import "SettingsViewController.h"
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameChange setPlaceholder:self.profile.name];
    self.profilePic.file = self.profile.image;
    [self.profilePic loadInBackground];
    // Do any additional setup after loading the view.
}

- (IBAction)changePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        NSLog(@"Camera not available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    [self.profilePic setImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveChanges:(id)sender {
    if(![self.nameChange.text isEqualToString:@""]){
        self.profile.name = self.nameChange.text;
        self.profile[@"name"] = self.profile.name;
        NSLog(@"%@", self.profile[@"name"]);
        [self.profile saveInBackground];
    }
    self.profile.image = [self.profile getPFFileFromImage:self.profilePic.image];
    self.profile[@"image"] = self.profile.image;
    [self.profile saveInBackground];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *TabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self presentViewController:TabBarController animated:YES completion:^{}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
 */

@end
