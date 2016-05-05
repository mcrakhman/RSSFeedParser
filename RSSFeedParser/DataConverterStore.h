

#ifndef DataConverterStore_h
#define DataConverterStore_h

@protocol DataConverterStore <NSObject>

- (void) addFeed: (FeedPlainObject *) feed;
- (FeedCellModel *) feedAtIndex: (NSUInteger) index;
- (NSUInteger) totalFeeds;

@end

#endif /* DataConverterStore_h */
