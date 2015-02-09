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

@interface TweetDetailsViewController ()

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

}

-(void) setTweetObj:(Tweet *)tweetObj{
    _tweetObj = tweetObj;
}

-(void) onReply {
    

}
- (IBAction)onTapFav:(id)sender {
    
    NSMutableDictionary *idParam = [[NSMutableDictionary alloc] init];
    [idParam setObject:[NSNumber numberWithInteger:self.tweetObj.tweetId] forKey:@"id"];
    
    BOOL isCreate = TRUE;
    if(self.tweetObj.isFaved){
        isCreate = FALSE;
    }
    
    [[TwitterClient sharedInstance] createFavWithParams:idParam isCreate:isCreate completion:^(Tweet *tweet, NSError *error) {
        self.tweetObj.favCount = tweet.favCount;
        self.tweetObj.isFaved  = tweet.isFaved;
        [self reloadDetailedView];

    }];
}

@end
