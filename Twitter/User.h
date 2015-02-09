//
//  User.h
//  Twitter
//
//  Created by Chinmay Kini on 2/6/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import <Foundation/Foundation.h>

// these are defining this to use these are NSnotifications for knowing user logged in or logged out

// these are defined again .h file again  so that other views can access them again, hence define these as
// extern to tell that these files are also allcoated elsewhere
extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property ( nonatomic, strong) NSString *name;
@property ( nonatomic, strong) NSString *screenName;
@property ( nonatomic, strong) NSString *profileImageURL;
@property ( nonatomic, strong) NSString *tagLine;

-(id) initWithDictionary: (NSDictionary *) dictionary;

// User object to store in the current user, getter and setter for the same
+(User *)currentUser;
+(void)setCurrentUser:(User *)currentUser;

+(void) logOut;


@end
