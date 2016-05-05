
#ifndef MainFeedViewInterface_h
#define MainFeedViewInterface_h

@protocol MainFeedViewInput <NSObject>

- (void) updateDataForDisplayManager: (FeedPlainObject *) feed;
- (void) showAlertWithError: (NSError *) error;

@end

#endif /* MainFeedViewInterface_h */
