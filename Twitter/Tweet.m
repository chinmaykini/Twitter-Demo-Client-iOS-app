//
//  Tweet.m
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "Tweet.h"
#import "TwitterClient.h"

@implementation Tweet

// define this class to create a model of a user or tweet from the Dictionary that you get from the REST API
-(id) initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    
    if(self){
        
        self.tweetId = [dictionary[@"id"] integerValue];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        self.reTweetCount  = [dictionary[@"retweet_count"] integerValue];
        self.favCount  = [dictionary[@"favorite_count"] integerValue];
        self.isReTweeted  = [dictionary[@"retweeted"] boolValue];
        self.isFaved  = [dictionary[@"favorited"] boolValue];
        
        // date is tricky will need formatter
        // date is in this format of string "Fri Feb 06 09:45:18 +0000 2015" mention that in the formatter
        NSString *createdAtString   = dictionary[@"created_at"];
        NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
        formatter.dateFormat        = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt              = [formatter dateFromString:createdAtString];
        
    }
    
    return self;
}

+(NSArray *) tweetsWithArray:(NSArray *)array{
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *dictionary in array){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    
    return tweets;
}

-(void)fav{
    
        NSMutableDictionary *idParam = [[NSMutableDictionary alloc] init];
        [idParam setObject:[NSNumber numberWithInteger:self.tweetId] forKey:@"id"];
    
        BOOL isCreate = TRUE;
        if(self.isFaved){
            isCreate = FALSE;
        }
    
        [[TwitterClient sharedInstance] createFavWithParams:idParam isCreate:isCreate completion:^(Tweet *tweet, NSError *error) {
//            NSLog(@"chinma this");
            if(tweet != nil){
                self.favCount = tweet.favCount;
                self.isFaved  = tweet.isFaved;
                [self.delegate tweet:self didUpdateTweet:self];
            }
        }];
    
    
}


-(void)reTweet{
    
//    NSMutableDictionary *idParam = [[NSMutableDictionary alloc] init];
//    [idParam setObject:[NSNumber numberWithInteger:self.tweetId] forKey:@"id"];
    
//    BOOL isCreate = TRUE;
//    if(self.isFaved){
//        isCreate = FALSE;
//    }
    
    [[TwitterClient sharedInstance] createReTweetWithParams:nil tweetId:[NSNumber numberWithInteger:self.tweetId] completion:^(Tweet *tweet, NSError *error) {
        if(tweet != nil){
            self.reTweetCount = tweet.reTweetCount;
            self.isReTweeted  = tweet.isReTweeted;
            [self.delegate tweet:self didUpdateTweet:self];
        }
    }];
    
}

@end
