//
//  TwitterClient.m
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"7zzT7ZhZqtEDUmAbFHxgnWwUk";
NSString * const kTwitterConsumerSecret = @"hmajsadrFxxM6FYJbLhbEFWHQlWrk8cY5AjSBZJxRfxE4QATh6";
NSString * const kTwitterBaseURL = @"https://api.twitter.com";

@interface TwitterClient()                                                          // not sure why the class extesnion is required

@property( strong, nonatomic) void (^loginCompletion)(User *user , NSError *error); // not sure why this was required

@end

@implementation TwitterClient

+( TwitterClient *) sharedInstance{
    
    // Its good to have a API client that a singleton, hece create it this way, hence static
    
    static TwitterClient *instance = nil;
    
    //put the null check in dispatch block to make it thread safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil){
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseURL] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    
    return instance;
}

-(void) loginWithCompletion:(void (^)(User *user , NSError *error))completion{
    
    //create the property above inside the class extension..not still sure why that was done
    self.loginCompletion = completion;
    
    
    // this is to clear out previous token that you have logged in previusly
    // if you dont do this you will get a 401 if the user was logged in previously and tries to use the same token
    
    // initially it was in logocn controll, now since we moved here its self
    //    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [self.requestSerializer removeAccessToken];
    
    // this is requesting token
    // initially it was in logocn controll, now since we moved here its self
    //    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"CKTwitterClient://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
    
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"CKTwitterClient://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got the token");
        
        // remember u have to append oauth token to this url to show it to users
        // we pass the request token we got to this url
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",requestToken.token]];
        
        // used the UI application singleton to open this url.
        [[UIApplication sharedApplication] openURL:authURL];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the token %@", error);
        
        // not sure how this wprls as well
        self.loginCompletion(nil, error); // error that u didnt get a user hence nil and handle teh error
    }];
    
}

-(void) openUrl:(NSURL *)url{
    
    // get the access token, last step in oauth process
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        
        NSLog(@"Got the access Token");
        
        // at this point every request that you make will be an autheticated request, so save the access token
        [self.requestSerializer saveAccessToken:accessToken];
        
        // you can hit any end point from here ( rest documentation )
        
        // this end point og twitter gets the logged in user
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // NSLog(@"current user : %@", responseObject);
            
            // set the User model
            User *user = [[User alloc] initWithDictionary:responseObject];
            
            // save the logged in user, teh setter that save it in user defaults
            [User setCurrentUser:user];
            
            // at this point you have login completion, user and no error, call the custom function
            self.loginCompletion(user, nil);
            
            NSLog(@" current user Name : %@", user.name);
            NSLog(@" current user Name : %@", user.screenName);
            NSLog(@" current user Name : %@", user.profileImageURL);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed getting current user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token %@", error);
    }];

    
}


#pragma mark - Twitter methods REST calls here

// define this methods here so that your open URL is clean

- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error))completion{
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil); // on this completion the code where you call homeTImeLine is called.
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) createFavWithParams:(NSDictionary *) params isCreate:(BOOL)isCreate completion:(void (^)(Tweet *tweet, NSError *error))completion{
    
//    NSLog(@"PARAMS : %@",params);
    
    NSString *postString = @"";
    if(isCreate){
        postString = @"1.1/favorites/create.json";
    }else{
        postString = @"1.1/favorites/destroy.json";
    }

    [self POST:postString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil,error);
    }];
}

- (void) updateTweetWithParams:(NSDictionary *) params completion:(void (^)(Tweet *tweet, NSError *error))completion{
    
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil); // on this completion the code where you call homeTImeLine is called.
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         completion(nil, error);
    }];

}

- (void) createReTweetWithParams:(NSDictionary *) params tweetId:(NSNumber *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion{

    NSString *postString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json",tweetId];
    [self POST:postString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil,error);
    }];
    
}

@end
