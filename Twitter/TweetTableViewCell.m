//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TweetComposeViewController.h"
#import "NSDate+TimeAgo.h"
#import "TwitterClient.h"

@interface TweetTableViewCell () <TweetDelegate>

- (IBAction) onProfileImageTap:(UITapGestureRecognizer *)sender;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    // To make sure the text doesnt run into the next lable. this and implement teh fucntion layoutsubviews
    self.unameLabel.preferredMaxLayoutWidth = self.unameLabel.frame.size.width;
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    
    // to round the corners
    self.profileImage.layer.cornerRadius  = 4;
    self.profileImage.clipsToBounds       = YES;
    
     self.tweet.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter and setters

- (void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
    
    User *tweetUser = self.tweet.user;
    
    // set the stuff from model
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweetUser.profileImageURL]];
    self.tweetLabel.text = self.tweet.text;
    self.screenNameLabel.text = tweetUser.screenName;
    self.unameLabel.text = tweetUser.name;
    
//    self.retweetLabel.text = @"";
//    if(self.tweet.isReTweeted){
//        self.retweetLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweetUser.screenName];
//    }
    
    UIImage *favImage = [UIImage imageNamed:@"favorite.png"];
    [self.favButton setImage:favImage forState:UIControlStateNormal];
    
    favImage = [UIImage imageNamed:@"favorite_on.png"];
    [self.favButton setImage:favImage forState:UIControlStateSelected];
    
    
    // Faved
    self.favButton.selected = self.tweet.isFaved;
    
    // RE-tweeted
    if(self.tweet.isReTweeted){
        UIImage *reTweetImg = [UIImage imageNamed:@"retweet_on.png"];
        [self.retweetButton setImage:reTweetImg forState:UIControlStateNormal];
    } else{
        UIImage *reTweetImg = [UIImage imageNamed:@"retweet.png"];
        [self.retweetButton setImage:reTweetImg forState:UIControlStateNormal];
    }
    
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@ ago",[self.tweet.createdAt timeAgoSimple]];
    
    UITapGestureRecognizer *profileImageTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileImageTap:)];
    [self.profileImage addGestureRecognizer:profileImageTapGes];
    
}


// implemet this fucntion to align stuff properly
-(void) layoutSubviews{
    [super layoutSubviews];
    // To make sure the text doesnt run into the next lable. this and implement teh fucntion layoutsubviews
    self.unameLabel.preferredMaxLayoutWidth = self.unameLabel.frame.size.width;
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

- (IBAction)onFavTap:(id)sender {
    
    // I am gona fav my tweet, listen to it when it changes
    // Not sure why i need to listen again, and the call on awake nib is not good enuf;
     self.tweet.delegate = self;
    [self.tweet fav];
    
    self.favButton.selected = !self.favButton.selected;
}

- (IBAction)onReTweetTap:(id)sender {
    if(!self.tweet.isReTweeted){
         self.tweet.delegate = self;
        [self.tweet reTweet];
        
    } else {
        NSLog(@"Need to implement destroy re-tweet");
    }
}

- (IBAction)onReplyTap:(id)sender {
    
//    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] init];
//    tcvc.replyScreenName            = self.tweet.user.screenName;
//    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tcvc];
//    [self. presentViewController:nc animated:YES completion:nil];
    [self.delegate tweetTableViewCell:self replyClicked:self.tweet];
    
}

-(void)tweet:(Tweet *)tweet didUpdateTweet:(Tweet *)tweetIn{
    
    if(tweetIn!=nil){
//        NSLog(@"Tweet Changed is fave :%@", self.tweet.isFaved);
        self.tweet = tweetIn;
        
        // who ever is listening, my cell values have changed
        [self.delegate tweetTableViewCell:self didUpdateValue:self];
    }
    
}

- (IBAction)onProfileImageTap:(UITapGestureRecognizer *)sender {
    
//    NSMutableDictionary *userParam = [[NSMutableDictionary alloc] init];
//    [userParam setObject:[NSNumber numberWithInteger:self.tweet.user.userId] forKey:@"user_id"];
//    [userParam setObject:self.tweet.user.screenName forKey:@"screen_name"];
//    
//    [[TwitterClient sharedInstance] getUserWithParams:userParam completion:^(User *user, NSError *error) {
//        self.user = user;
//        [self reloadView];
//    }];

    [self.delegate tweetTableViewCell:self profileImageClicked:self.tweet.user];
}

@end
