//
//  FeedDataConverterStoreTests.m
//  RSSFeedParser
//
//  Created by MIKHAIL RAKHMANOV on 05.05.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FeedDataConverterStore.h"

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

- (void) testThatFeedsAreAddedAndSortedAndTheRightAmountOfThemProvidedToTheCaller {
	
	// given
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSString *stringFirstDate = @"2016-05-02 10:00:00";
	NSDate *firstDate = [dateFormatter dateFromString:stringFirstDate];
	NSString *stringSecondDate = @"2016-05-02 11:00:00";
	NSDate *secondDate = [dateFormatter dateFromString:stringSecondDate];
	
	FeedPlainObject *firstObject = [FeedPlainObject new];
	FeedPlainObject *secondObject = [FeedPlainObject new];
	
	FeedCellModel *firstModel = [FeedCellModel new];
	firstModel.date = firstDate;
	
	FeedCellModel *secondModel = [FeedCellModel new];
	secondModel.date = secondDate;
	
	OCMStub ([self.mockConverter convertFeed:firstObject]).andReturn (firstModel);
	OCMStub ([self.mockConverter convertFeed:secondObject]).andReturn (secondModel);
	
	// when
	
	// the sorting is made on the async background queue
	[self.store addFeed:firstObject]; // with earlier date
	[self.store addFeed:secondObject]; // with later date
	
	// then
	
	// we are sure that the array is sorted after the time is exceeded
	dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
	
	if (dispatch_semaphore_wait(semaphore, timeoutTime)) {
		
		XCTAssert ([self.store totalFeeds] == 2);
		
		XCTAssert ([self.store feedAtIndex:0] == secondModel); // the latest date shall be at the beginning of the array
	}
}

- (void) newTest {
	
}

@end
