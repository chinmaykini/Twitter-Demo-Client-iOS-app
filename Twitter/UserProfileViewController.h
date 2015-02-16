//
//  UserProfileViewController.h
//  Twitter
//
//  Created by Chinmay Kini on 2/15/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;

@property( strong, nonatomic) User *user;
@property( nonatomic, assign) NSInteger userIdIn;
@property( nonatomic, strong) NSString *screenNameIn;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;

@end
