//
//  TweetComposeViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TweetComposeViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface TweetComposeViewController ()

@end

@implementation TweetComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.navigationController.navigationBar.barTintColor    = [UIColor cyanColor];
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent     = YES;
//    self.navigationItem.title                               = @"Home";
    UIImageView *titleLogo  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter_logo_white_32.png"]];
    self.navigationItem.titleView = titleLogo;

    
    // Signout button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    
    // New Tweet button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    // get the current user
    User *user = [User currentUser];
    
    self.posterImage.layer.cornerRadius  = 4;
    self.posterImage.clipsToBounds       = YES;
    [self.posterImage setImageWithURL:[NSURL URLWithString:user.profileImageURL]];
    
    self.uNameFeild.text = user.name;
    self.screenNameFeild.text = user.screenName;
    
    [self.tweetInputFeild becomeFirstResponder];
    if([self.replyScreenName length]>0){
//        self.tweetInputFeild.text = [NSString stringWithFormat:@"@%@",self.replyScreenName];
        [self.tweetInputFeild setText:[NSString stringWithFormat:@"%@ ",self.replyScreenName]];
    }
    
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

-(void)onCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onTweet{
    
    NSLog(@"%d", (int)[self.tweetInputFeild.text length]);
    if([self.tweetInputFeild.text length] > 0){
        NSMutableDictionary *statusParam = [[NSMutableDictionary alloc] init];
        [statusParam setObject:self.tweetInputFeild.text forKey:@"status"];
        
        [[TwitterClient sharedInstance] updateTweetWithParams:statusParam completion:^(Tweet *tweet, NSError *error) {
            if(tweet != nil){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
    
}

@end
