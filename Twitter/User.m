//
//  User.m
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

// these are defining this to use these are NSnotifications for knowing user logged in or logged out
NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property(nonatomic, strong) NSDictionary *dictionary;


@end

@implementation User

// define this class to create a model of a user or tweet from the Dictionary that you get from the REST API
-(id) initWithDictionary: (NSDictionary *) dictionary{
    
    self = [super init];
    
    if(self){
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = [NSString stringWithFormat:@"@%@",dictionary[@"screen_name"]];
        self.profileImageURL = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"description"];
    }
    
    return self;
}


// User object to store in the current user, getter and setter for the same

static User *_currentUser = nil;

NSString * const kCurrentUSerKey = @"kCurrentUserKey";

+(User *)currentUser{
    
    // 1) either your logged out
    // 2) comign back froma  cold start
    if( _currentUser == nil){
        // get it from ns user defaults usign key
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUSerKey];
        if(data != nil){
            
            // need to serialize it cause nd user defaults is not serialised auto
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser             = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+(void)setCurrentUser:(User *)currentUser{
    _currentUser = currentUser;
    
    // do the flip side of getter
    if(_currentUser != nil){
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUSerKey];
        
    } else {
        
        //even if its nill set it to clear out previosly logged in user
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUSerKey];
    }
    // periodically synchronise, dont forget, to force it when u set
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) logOut{
    
    // set the current user to nil
    // remove the access token for the user
    
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer  removeAccessToken];
    
    //post that you logged out
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end
