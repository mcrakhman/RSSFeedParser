
#ifndef DataDisplayManager_h
#define DataDisplayManager_h

#import <UIKit/UIKit.h>
#import "FeedCell.h"
#import "CellConfiguration.h"

@protocol DataDisplayManager <UITableViewDataSource, UITableViewDelegate>

- (void) setTableView: (UITableView *)tableView andCellConfiguration: (CellConfiguration) configuration;
- (void) addFeed: (FeedPlainObject *) feed;

@end



#endif /* DataDisplayManager_h */
