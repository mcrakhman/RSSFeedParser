
#import <Foundation/Foundation.h>
#import "FeedPlainObject.h"
#import "FeedCellModel.h"
#import "InDateFormatter.h"
#import "OutDateFormatter.h"

/**
 The protocol converts plain data acquired by the service
 to cell model data.
 */
@protocol DataConverter <NSObject>

- (FeedCellModel *) convertFeed: (FeedPlainObject *) feed;
- (UIImage *) convertNSDataToImageDependingOnCellConfiguration: (NSData *) data;

@end

@protocol FeedConverterDelegate <NSObject>

- (CellConfiguration) getCellConfiguration;

@end

@interface FeedConverter : NSObject <DataConverter>
/**
 This date formatter converts RSS date string to nsdate
 */
@property (nonatomic, strong, readwrite) id <InDateFormatter> dateReceiverFormatter;
/**
 This date formatter converts nsdate to respective date format
 which the cell will display
 */
@property (nonatomic, strong, readwrite) id <OutDateFormatter> stringReceiverFormatter;
/** The delegate is the data display manager which knows the cell configuration
 */
@property (nonatomic, weak, readwrite) id <FeedConverterDelegate> delegate;

@end
