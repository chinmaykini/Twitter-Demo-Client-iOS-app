//
//  TwitterClient.h
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+( TwitterClient *) sharedInstance;

// Create this new method to avoid all the dirty code on login in the login controller
// we pass in the completion block , it has 2 params user and erro, its  void blok
-(void) loginWithCompletion:(void (^)(User *user , NSError *error))completion;

//create a custom functin for opening url and moving those funcitons to twitter client
-(void) openUrl:(NSURL * ) url;

- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void) updateTweetWithParams:(NSDictionary *) params completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void) createFavWithParams:(NSDictionary *) params isCreate:(BOOL)isCreate completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void) createReTweetWithParams:(NSDictionary *) params tweetId:(NSNumber *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion;


@end
