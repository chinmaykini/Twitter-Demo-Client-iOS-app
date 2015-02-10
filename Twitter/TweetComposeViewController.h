//
//  TweetComposeViewController.h
//  Twitter
//
//  Created by Chinmay Kini on 2/8/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *uNameFeild;
@property (weak, nonatomic) IBOutlet UILabel *screenNameFeild;
@property (weak, nonatomic) IBOutlet UITextField *tweetInputFeild;
@property(strong, nonatomic) NSString *replyScreenName;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *charCountButton;

@end
