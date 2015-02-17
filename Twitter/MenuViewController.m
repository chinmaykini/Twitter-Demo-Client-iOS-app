//
//  MenuViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/16/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "MenuViewController.h"
#import "UserProfileViewController.h"
#import "MentionsViewController.h"
#import "TweetsViewController.h"
#import "ContentViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Menu View willDidLoad");
    // Do any additional setup after loading the view from its nib.
    
    self.me = [User currentUser];
    
    self.profileImage.layer.cornerRadius  = 5;
    self.profileImage.clipsToBounds       = YES;
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.me.profileImageURL]];
    
    self.nameFeild.text = self.me.name;
    self.screenNameFeild.text = self.me.screenName;
    self.descritpionField.text = self.me.tagLine;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Menu View didAppear");
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"Menu View didDisappear");
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Menu View willAppear");
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"Menu View willDisappear");
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
- (IBAction)onProfileTap:(id)sender {
    UserProfileViewController *upvc = [[UserProfileViewController alloc] init];
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:upvc];
    
    upvc.userIdIn = self.me.userId;
    upvc.screenNameIn = self.me.screenName;
    [self presentViewController:nc animated:YES completion:nil];
}

- (IBAction)onMentionsTap:(id)sender {
    
    MentionsViewController *mvc = [[MentionsViewController alloc] init];
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    nc.view.frame = self.view.frame;

    [self presentViewController:nc animated:YES completion:nil];

}
- (IBAction)onTimelineTap:(id)sender {
    ContentViewController *cvc =   [[ContentViewController alloc] init];
    [self presentViewController:cvc animated:YES completion:nil];
}
- (IBAction)onProfileImageTap:(UITapGestureRecognizer *)sender {
    
    UserProfileViewController *tvc       = [[UserProfileViewController alloc] init];
    tvc.userIdIn = self.me.userId;
    tvc.screenNameIn = self.me.screenName;
    
    UINavigationController *nc      = [[UINavigationController alloc] initWithRootViewController:tvc];
    [self presentViewController:nc animated:YES completion:nil];
    
}

@end
