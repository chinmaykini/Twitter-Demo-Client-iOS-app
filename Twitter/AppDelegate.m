//
//  AppDelegate.m
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "ContentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // add listener for logged in and logged out
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    // you should be able to chec if the user is logged in
    User  *user = [User currentUser];
    if( user != nil){
        NSLog(@"Welcome %@", user.screenName);
        
        ContentViewController *tvc = [[ContentViewController alloc] init];
        self.window.rootViewController  = tvc;
        
    } else{
        NSLog(@"Not Logged in");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// @@@@@@@@@@@@    TODO : chinmay whenever you have a redirect, write this fucntion
// this fucntion is called whenever someone tries to open your application and the query String is passed in the url parameter

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    // custom function declared to open the login url to make clode clean
    [[TwitterClient sharedInstance] openUrl:url];
    
//    // get the access token, last step in oauth process
//    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
//        NSLog(@"Got the access Token");
//        
//        // at this point every request that you make will be an autheticated request, so save the access token
//        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
//        
//        // you can hit any end point from here ( rest documentation )
//        
//        // this end point og twitter gets the logged in user
//        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
////            NSLog(@"current user : %@", responseObject);
//            
//            // set the User model
//            User *user = [[User alloc] initWithDictionary:responseObject];
//            NSLog(@" current user Name : %@", user.name);
//            NSLog(@" current user Name : %@", user.screenName);
//            NSLog(@" current user Name : %@", user.profileImageURL);
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Failed getting current user");
//        }];
//        
//        
//        // this end point of twitter gets the tweets
//        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
////            NSLog(@"tweets : %@", responseObject);
//            
//            // this builds the Array of Tweet models 
//            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//            
//            for(Tweet *tweet in tweets)
//            {
//                NSLog(@"tweet : %@, createdAt : %@", tweet.text, tweet.createdAt);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Failed getting tweets for user");
//        }];
//        
//        
//        
//        
//    } failure:^(NSError *error) {
//        NSLog(@"Failed to get the access token %@", error);
//    }];

    return YES;
}

-(void) userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

@end
