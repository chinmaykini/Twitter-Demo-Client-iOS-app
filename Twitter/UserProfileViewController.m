//
//  UserProfileViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/15/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "UserProfileViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "TweetComposeViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor    = [UIColor colorWithRed:0.40196557852924675 green:0.77594807697599411 blue:1 alpha:1];
    
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];
    //  self.navigationController.navigationBar.translucent     = YES;
    
    //  button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStyleDone target:self action:@selector(onCompose)];

    self.profileImage.layer.cornerRadius  = 6;
    self.profileImage.clipsToBounds       = YES;
    
    [self loadTimeline];

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

-(void) loadTimeline{
    
    NSMutableDictionary *userParam = [[NSMutableDictionary alloc] init];
    [userParam setObject:[NSNumber numberWithInteger:self.userIdIn] forKey:@"user_id"];
    [userParam setObject:self.screenNameIn forKey:@"screen_name"];
    
    [[TwitterClient sharedInstance] getUserWithParams:userParam completion:^(User *user, NSError *error) {
        self.user = user;
        [self reloadView];
    }];
}

-(void) reloadView{
    
//    self.seperatorView.frame.size = CGSizeMake(self.view.frame.size.width, 3);

    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageURL]];
    self.followingCount.text    = [NSString stringWithFormat:@"%d",(int)self.user.friendsCount];
    self.followersCount.text    = [NSString stringWithFormat:@"%d",(int)self.user.followersCount];
    self.tweetCount.text        = [NSString stringWithFormat:@"%d",(int)self.user.statusCount];
    self.screenName.text        = self.user.screenName;
    self.userName.text          = self.user.name;

    User *tmpUser = [User currentUser];
    
    
    self.navigationItem.title =self.user.name;
    NSLog(@"temp user %@", tmpUser.screenName);
    NSLog(@"self user %@", self.user.screenName);

    if([tmpUser.screenName isEqualToString:self.user.screenName]){
        NSLog(@"inside");
        self.navigationItem.title = @"Me";
    }
    
}


-(void) onCompose {
    
    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] init];
    tcvc.replyScreenName            = @"";
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tcvc];
    
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}


-(void)onCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
