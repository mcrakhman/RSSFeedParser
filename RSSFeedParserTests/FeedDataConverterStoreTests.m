
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FeedDataConverterStore.h"

@interface FeedDataConverterStore (PrivateMethods)

- (void) sortCellModels;
- (void) sortUpdateArrayWithNewFeed: (FeedPlainObject *) feed;
- (void) convertFeedAndAddAsACellModel: (FeedPlainObject *) feed;

@end

@interface FeedDataConverterStoreTests : XCTestCase

@property (strong, nonatomic, readwrite) FeedDataConverterStore *store;
@property (strong, nonatomic, readwrite) id mockConverter;

@end

@implementation FeedDataConverterStoreTests

- (void)setUp {
    [super setUp];
	
	self.store = [FeedDataConverterStore new];
	self.mockConverter = OCMProtocolMock(@protocol(DataConverter));
	self.store.converter = self.mockConverter;
}

- (void)tearDown {
	
	self.mockConverter = nil;
	self.store = nil;
	
    [super tearDown];
}

- (void) testThatFeedsAreAddedToTheArrayAndCorrectElementsReturned {
	
	// given
	
	FeedPlainObject *firstObject = [FeedPlainObject new];
	FeedPlainObject *secondObject = [FeedPlainObject new];
	FeedCellModel *firstModel = [FeedCellModel new];
	FeedCellModel *secondModel = [FeedCellModel new];
	
	OCMStub ([self.mockConverter convertFeed:firstObject]).andReturn (firstModel);
	OCMStub ([self.mockConverter convertFeed:secondObject]).andReturn (secondModel);
	
	// when
	
	[self.store convertFeedAndAddAsACellModel:firstObject];
	[self.store convertFeedAndAddAsACellModel:secondObject];
	
	// then
	
	XCTAssert(self.store.feeds.count == 2);
	XCTAssert(self.store.feeds [0] == firstModel);
	XCTAssert(self.store.feeds [1] == secondModel);
	
	XCTAssert([self.store totalFeeds] == 2);
	XCTAssert([self.store feedAtIndex:0] == firstModel);
	XCTAssert([self.store feedAtIndex:1] == secondModel);
	
}

- (void) testThatTheFeedsAreProperlySorted {
	
	// given
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSString *stringFirstDate = @"2016-05-02 10:00:00";
	NSDate *firstDate = [dateFormatter dateFromString:stringFirstDate];
	NSString *stringSecondDate = @"2016-05-02 11:00:00";
	NSDate *secondDate = [dateFormatter dateFromString:stringSecondDate];
	
	FeedCellModel *firstModel = [FeedCellModel new];
	firstModel.date = firstDate;
	
	FeedCellModel *secondModel = [FeedCellModel new];
	secondModel.date = secondDate;
	
	[self.store.feeds addObjectsFromArray:@[firstModel, secondModel]];
	
	// when
	
	[self.store sortCellModels];
	
	// then
	
	XCTAssert (self.store.feeds[0] == secondModel);
	
}


@end
