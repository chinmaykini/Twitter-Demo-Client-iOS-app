//
//  MenuViewController.h
//  Twitter
//
//  Created by Chinmay Kini on 2/16/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameFeild;
@property (weak, nonatomic) IBOutlet UILabel *screenNameFeild;
@property (weak, nonatomic) IBOutlet UILabel *descritpionField;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *mentionsButton;
@property (weak, nonatomic) IBOutlet UIButton *timelineButton;
@property( nonatomic, strong) User *me;

@end
