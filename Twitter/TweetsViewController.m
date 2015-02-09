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

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (strong, nonatomic) NSArray *myTweetsArray;


@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tweetsTableView.dataSource   = self;
    self.tweetsTableView.delegate     = self;
    
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationController.navigationBar.barTintColor    = [UIColor cyanColor];
    self.navigationController.navigationBar.tintColor       = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent     = YES;
    self.navigationItem.title                               = @"Home";
    
    // Signout button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOut)];
    
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.myTweetsArray = tweets;
//        NSLog(@"%@", self.myTweetsArray);
        [self.tweetsTableView reloadData];
//        for(Tweet *tweet in tweets){
//            NSLog(@"tweet text : %@", tweet.text);
//        }
    }];
    
    
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
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] init];
    tdvc.tweetObj                       = self.myTweetsArray[indexPath.row];;
    
    
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
@end
