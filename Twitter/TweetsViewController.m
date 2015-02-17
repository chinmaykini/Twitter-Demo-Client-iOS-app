//
//  TweetsViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/7/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "TweetDetailsViewController.h"
#import "TweetComposeViewController.h"
#import "UserProfileViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, TweetTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (strong, nonatomic) NSArray *myTweetsArray;

@property (nonatomic, strong) UIRefreshControl *refreshControl;



@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       NSLog(@"Tweet View willDidLoad");
    // Do any additional setup after loading the view from its nib.
    
    self.tweetsTableView.dataSource   = self;
    self.tweetsTableView.delegate     = self;
    
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Twitter Color
    self.navigationController.navigationBar.barTintColor    = [UIColor colorWithRed:0.40196557852924675 green:0.77594807697599411 blue:1 alpha:1];
    
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent     = YES;
    
    UIImageView *titleLogo  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter_logo_white_32.png"]];
    self.navigationItem.titleView = titleLogo;
//    self.navigationItem.title                               = @"Home";
    
    // Signout button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(onSignOut)];
    
    // New Tweet button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStyleDone target:self action:@selector(onNew)];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTableView insertSubview:self.refreshControl atIndex:0];
    
    [self loadTimeline];
}


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Tweet View didAppear");
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"Tweet View didDisappear");
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Tweet View willAppear");
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"Tweet View willDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.myTweetsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"Section %ld Row %ld", indexPath.section, indexPath.row);
    
    TweetTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    cell.tweet                = self.myTweetsArray[indexPath.row];
    
    // listen to the cell change event
    cell.delegate   = self;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"selected Tweet Cell");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] init];
    tdvc.tweetObj                    = self.myTweetsArray[indexPath.row];;
//    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tdvc];
//    [self.navigationController pushViewController:tdvc animated:YES completion:nil];
    [self.navigationController pushViewController:tdvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) onSignOut {
    [User logOut];
}

-(void) onNew {
    
    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] init];
    tcvc.replyScreenName            = @"";
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tcvc];
    
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

-(void) onRefresh {
    [self loadTimeline];
    [self.refreshControl endRefreshing];
}

-(void) loadTimeline{
    
    NSMutableDictionary *countParam = [[NSMutableDictionary alloc] init];
    [countParam setObject:[NSNumber numberWithInteger:199] forKey:@"count"];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:countParam completion:^(NSArray *tweets, NSError *error) {
        self.myTweetsArray = tweets;
        //        NSLog(@"%@", self.myTweetsArray);
        [self.tweetsTableView reloadData];
        //        for(Tweet *tweet in tweets){
        //            NSLog(@"tweet text : %@", tweet.text);
        //        }
    }];
}

#pragma mark - Delegate Methods
-(void)tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell didUpdateValue:(TweetTableViewCell *)tweetCell{
    
    NSIndexPath *indexPath = [self.tweetsTableView indexPathForCell:tweetCell];
//    NSLog(@"received Cell is Faved : %@", tweetCell.tweet.isFaved);
    
//    TweetTableViewCell *cell = [self.tweetsTableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"Dequeued Cell is Faved : %@", cell.tweet.isFaved);
    // how do you refresh just his cell from index path
    [self.tweetsTableView reloadData];

}

-(void)tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell profileImageClicked:(User *)clickedUser{

    UserProfileViewController *tvc       = [[UserProfileViewController alloc] init];
    tvc.userIdIn = clickedUser.userId;
    tvc.screenNameIn = clickedUser.screenName;
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tvc];
    [self presentViewController:nc animated:YES completion:nil];

}

-(void)tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell replyClicked:(Tweet *)replyTweet{
    TweetComposeViewController *tcvc = [[TweetComposeViewController alloc] init];
    tcvc.replyScreenName            = replyTweet.user.screenName;
    tcvc.replyTweetId               = replyTweet.tweetId;
    tcvc.isReply                    = YES;
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tcvc];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}
@end
