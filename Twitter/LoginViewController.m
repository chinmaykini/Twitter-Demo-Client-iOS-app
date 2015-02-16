//
//  LoginViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "TweetsViewController.h"
#import "MentionsViewController.h"
#import "UserProfileViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil){
            // modally preset the tweets view
            NSLog(@"Welcome to %@", user.screenName);
            
            TweetsViewController *tvc       = [[TweetsViewController alloc] init];
//            UserProfileViewController *tvc       = [[UserProfileViewController alloc] init];
            
//            tvc.userIdIn = user.userId;
//            tvc.screenNameIn = user.screenName;

//            MentionsViewController *tvc       = [[MentionsViewController alloc] init];
            UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tvc];
            
//            [self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
            [self presentViewController:nc animated:YES completion:nil];
        } else {
            // present error view
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
