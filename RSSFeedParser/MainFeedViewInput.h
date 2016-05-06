
#ifndef MainFeedViewInterface_h
#define MainFeedViewInterface_h

#import "CellConfiguration.h"

@protocol MainFeedViewInput <NSObject>

- (void) updateDataForDisplayManager: (FeedPlainObject *) feed;
- (void) setupInitialStateWithCellConfiguration: (CellConfiguration) cellConfiguration;
- (void) showAlertWithError: (NSError *) error;

@end

#endif /* MainFeedViewInterface_h */
