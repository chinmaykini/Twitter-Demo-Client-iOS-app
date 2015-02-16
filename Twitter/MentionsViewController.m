//
//  MentionsViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/13/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "MentionsViewController.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"

@interface MentionsViewController ()  <UITableViewDataSource, UITableViewDelegate, TweetTableViewCellDelegate>

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mentionsTableView.dataSource   = self;
    self.mentionsTableView.delegate     = self;
    
    self.mentionsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.mentionsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];

    
    // Twitter Color
    self.navigationController.navigationBar.barTintColor    = [UIColor colorWithRed:0.40196557852924675 green:0.77594807697599411 blue:1 alpha:1];
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];

    
//    UIImageView *titleLogo  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter_logo_white_32.png"]];
//    self.navigationItem.titleView = titleLogo;
    self.navigationItem.title                               = @"Me";
    
    // Signout button
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(onSignOut)];
    
    // New Tweet button
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStyleDone target:self action:@selector(onNew)];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.mentionsTableView insertSubview:self.refreshControl atIndex:0];
    
    [self loadTimeline];
 
    
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

#pragma mark - private methods
-(void) onRefresh {
    [self loadTimeline];
    [self.refreshControl endRefreshing];
}

-(void) loadTimeline{
    
    NSMutableDictionary *countParam = [[NSMutableDictionary alloc] init];
    [countParam setObject:[NSNumber numberWithInteger:199] forKey:@"count"];
    
    [[TwitterClient sharedInstance] mentionsTimelineWithParams:countParam completion:^(NSArray *tweets, NSError *error) {
        self.mentionsTweetsArray = tweets;
        //        NSLog(@"%@", self.myTweetsArray);
        [self.mentionsTableView reloadData];
        //        for(Tweet *tweet in tweets){
        //            NSLog(@"tweet text : %@", tweet.text);
        //        }
    }];
}


#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mentionsTweetsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"Section %ld Row %ld", indexPath.section, indexPath.row);
    
    TweetTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    cell.tweet                = self.mentionsTweetsArray[indexPath.row];
    cell.delegate             = self;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] init];
//    tdvc.tweetObj                    = self.myTweetsArray[indexPath.row];;
//    
//    [self.navigationController pushViewController:tdvc animated:YES];
}

#pragma mark - delegates

-(void)tweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell didUpdateValue:(TweetTableViewCell *) tweetCell{
    NSIndexPath *indexPath = [self.mentionsTableView indexPathForCell:tweetCell];
    [self.mentionsTableView reloadData];
}

@end
