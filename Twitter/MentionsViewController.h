//
//  MentionsViewController.h
//  Twitter
//
//  Created by Chinmay Kini on 2/13/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MentionsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mentionsTableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *mentionsTweetsArray;

@end
