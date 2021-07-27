//
//  SignupViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/12/21.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>
#import "UserInfo.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signupPress:(id)sender {
    if([self.usernameText.text isEqual:@""] || [self.passwordText.text isEqual:@""] || [self.nameText.text isEqual:@""]){
        [self alertControllerCode];
    }else{
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameText.text;
        newUser.password = self.passwordText.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [UserInfo newUser:self.nameText.text withCompletion:^(BOOL succeeded, NSError *error){}];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SignupViewController *TabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                [self presentViewController:TabBarController animated:YES completion:^{
                }];
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
