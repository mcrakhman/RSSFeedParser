
#ifndef MainFeedInteractorOutput_h
#define MainFeedInteractorOutput_h

#import "FeedPlainObject.h"

@protocol MainFeedInteractorOutput <NSObject>

- (void) showFeed: (FeedPlainObject *)feed;
- (void) showError: (NSError *)error;

@end

#endif /* MainFeedInteractorOutput_h */
