//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TweetComposeViewController.h"


@interface TweetDetailsViewController () <TweetDelegate>

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationController.navigationBar.barTintColor    = [UIColor cyanColor];
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent     = YES;
    self.navigationItem.title                               = @"Tweet";
    
    
    // Signout button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
    
    self.tweetObj.delegate = self;
    
    [self reloadDetailedView];

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

-(void) reloadDetailedView{
    
    User *tweetUser = self.tweetObj.user;
    
    // set the stuff from model
    self.profileImage.layer.cornerRadius  = 4;
    self.profileImage.clipsToBounds       = YES;
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweetUser.profileImageURL]];
    
    //    self.reTweetLabel.text = @"";
    //    if(self.tweetObj.isReTweeted){
    //        self.reTweetLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweetUser.screenName];
    //    }
    
    self.tweetTextLabel.text = self.tweetObj.text;
    self.screenNameLabel.text = tweetUser.screenName;
    self.unameLabel.text = tweetUser.name;
    self.reTweetCountLabel.text = [NSString stringWithFormat:@"%d RETWEETS",(int)self.tweetObj.reTweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d FAVORITES",(int)self.tweetObj.favCount];
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat        = @"dd/MM/yy, hh:mm a";
    self.createdAtLabel.text    = [formatter stringFromDate:self.tweetObj.createdAt];
    
    
    // Faved
    if(self.tweetObj.isFaved){
        UIImage *favImage = [UIImage imageNamed:@"favorite_on.png"];
        [self.favButton setImage:favImage forState:UIControlStateNormal];
    } else{
        UIImage *favImage = [UIImage imageNamed:@"favorite.png"];
        [self.favButton setImage:favImage forState:UIControlStateNormal];
    }
    
    // RE-tweeted
    if(self.tweetObj.isReTweeted){
        UIImage *reTweetImg = [UIImage imageNamed:@"retweet_on.png"];
        [self.retweetButton setImage:reTweetImg forState:UIControlStateNormal];
    } else{
        UIImage *reTweetImg = [UIImage imageNamed:@"retweet.png"];
        [self.retweetButton setImage:reTweetImg forState:UIControlStateNormal];
    }

}

-(void) setTweetObj:(Tweet *)tweetObj{
    _tweetObj = tweetObj;
}

-(void) onReply {
    
    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] init];
    tcvc.replyScreenName            = self.tweetObj.user.screenName;
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tcvc];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
    
}
- (IBAction)onTapReply:(id)sender {
    [self onReply];
}

- (IBAction)onTapReTweet:(id)sender {
    
    if(!self.tweetObj.isReTweeted){
        [self.tweetObj reTweet];
    } else {
        NSLog(@"Need to implement destroy re-tweet");
    }
    
}


- (IBAction)onTapFav:(id)sender {

    [self.tweetObj fav];
}

-(void) tweet:(Tweet *)tweet didUpdateTweet:(Tweet *)tweetIn{
    
    if(tweetIn!=nil){
        self.tweetObj = tweetIn;
        [self reloadDetailedView];
    }

}

@end
