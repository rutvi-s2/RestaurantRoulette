//
//  LoginViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/12/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginPress:(id)sender {
    if([self.usernameText.text isEqual:@""] || [self.passwordText.text isEqual:@""]){
        [self alertControllerCode];
    }else{
        NSString *username = self.usernameText.text;
        NSString *password = self.passwordText.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *TabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                [self presentViewController:TabBarController animated:YES completion:^{
                }];
                // display view controller that needs to shown after successful login
            }
        }];
    }
}

-(void) alertControllerCode{
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"The password or username is empty" preferredStyle:UIAlertControllerStyleAlert];
       // create a cancel action
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { // handle cancel response here. Doing nothing will dismiss the view.
       }];
       // add the cancel action to the alertController
       [alert addAction:cancelAction];
       // create an OK action
       UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
           }];
       // add the OK action to the alert controller
       [alert addAction:okAction];
       
       [self presentViewController:alert animated:YES completion:^{
           // optional code for what happens after the alert controller has finished presenting
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
