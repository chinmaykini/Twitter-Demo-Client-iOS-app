//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    // To make sure the text doesnt run into the next lable. this and implement teh fucntion layoutsubviews
    self.unameLabel.preferredMaxLayoutWidth = self.unameLabel.frame.size.width;
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    
    // to round the corners
    self.profileImage.layer.cornerRadius  = 4;
    self.profileImage.clipsToBounds       = YES;
    
    
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
}


// implemet this fucntion to align stuff properly
-(void) layoutSubviews{
    [super layoutSubviews];
    // To make sure the text doesnt run into the next lable. this and implement teh fucntion layoutsubviews
    self.unameLabel.preferredMaxLayoutWidth = self.unameLabel.frame.size.width;
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}


@end
