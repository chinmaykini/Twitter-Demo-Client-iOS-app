//
//  Tweet.h
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property( strong, nonatomic) NSString *text;
@property( strong, nonatomic) NSDate *createdAt;
@property( nonatomic, assign) NSInteger reTweetCount;
@property( nonatomic, assign) NSInteger favCount;
@property( strong, nonatomic) User *user;
@property( nonatomic, assign) BOOL isReTweeted;
@property( nonatomic, assign) BOOL isFaved;
@property( nonatomic, assign) NSInteger tweetId;



-(id) initWithDictionary: (NSDictionary *) dictionary;

//helper method for all teh tweets since its an array of tweet in teh repsonse
// so use this to get the response and build a NSArray of Tweet objects
+(NSArray *) tweetsWithArray:(NSArray *)array;

@end
