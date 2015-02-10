//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

@class TweetTableViewCell;

@protocol TweetTableViewCellDelegate <NSObject>

-(void)tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell didUpdateValue:(TweetTableViewCell *) tweetCell;

@end

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *unameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *replyTweet;

@property(nonatomic, weak) id<TweetTableViewCellDelegate> delegate;

@property( strong, nonatomic) Tweet *tweet;

@end
