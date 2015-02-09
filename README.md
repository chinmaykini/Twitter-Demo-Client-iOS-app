# Twitter-Demo-Client-iOS-app
Simple Twitter Client Demo iOS App


This is a Simple Twitter Client that allows your to read your timeline, create tweets, fav, retweet, reply to tweets. 
The idea was to get introduced to OAuth, Storing User seesions, Auto Layout, Get and Post methods, handling Buttons in tableViewCells.

### Time Spent : 15 hours

### Completed user Stories

- [x] Required : User can sign in using OAuth login flow
- [x] Required : User can view last 20 tweets from their home timeline
- [x] Required : The current signed in user will be persisted across restarts
- [x] Required : In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
- [x] Required : User can pull to refresh
- [x] Required : User can compose a new tweet by tapping on a compose button.
- [x] Required : User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

- [ ] Optional: When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] Optional: After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Optional: Retweeting and favoriting should increment the retweet and favorite count.
- [x] Optional: User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Optional: Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] Optional: User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client

### Notes :

### Questions :
* How doe you reload just a particular cell in the table view, when a fav button is clicked on the cell from table view, the fav image or count should change. how to avoid reload data.
* a delegate on teh cell object needs to be called on awakenib & onFav and onREply, why so ?

### References
* Free iOS icons [glyphish](http://www.glyphish.com/)

### VideoWalkthroughs
* This [walkthrough](http://vimeo.com/107373841) takes you through the OAuth 1.0a authentication flow. At the end of this video, you'll be able to download tweets.
* This [walkthrough] (http://vimeo.com/107378059) shows you a pattern for saving the current user as well as firing and handling session events like signing in and signing out.

### [Video Walkthrough](TwitterClient.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
