
#ifndef FeedDataConverterStore_h
#define FeedDataConverterStore_h

#import "CellConfiguration.h"
#import "FeedConverter.h"
#import "DataConverterStore.h"

@interface FeedDataConverterStore : NSObject <DataConverterStore>

@property (nonatomic, strong, readwrite) id <DataConverter> converter;
@property (nonatomic, readwrite) CellConfiguration cellConfiguration;
@property (nonatomic, strong, readwrite) dispatch_queue_t queue;
@property (nonatomic, strong, readwrite) NSMutableArray *feeds;

- (id) init;

@end

#endif /* FeedDataConverterStore_h */
