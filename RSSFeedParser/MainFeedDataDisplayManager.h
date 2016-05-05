
#ifndef MainFeedDataDisplayManager_h
#define MainFeedDataDisplayManager_h

#import "DataDisplayManager.h"
#import "FeedConverter.h"
#import "DataConverterStore.h"

@interface MainFeedDataDisplayManager : NSObject <DataDisplayManager, FeedConverterDelegate>

@property (nonatomic, weak, readwrite) UITableView *tableView;
@property (nonatomic, readwrite) NSInteger selectedRowIndex;
@property (nonatomic, readwrite) CellConfiguration cellConfiguration;
@property (atomic, strong, readwrite) id <DataConverterStore> store;

@end

#endif /* MainFeedDataDisplayManager_h */
