
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Typhoon/Typhoon.h>
#import "CellConfigurationConstants.h"
#import "MainFeedDataDisplayManager.h"
#import "ViewController.h"

@interface DataDisplayManagerTests : XCTestCase

@property (nonatomic, strong, readwrite) MainFeedDataDisplayManager *manager;
@property (nonatomic, strong, readwrite) id mockTableView;

@end

@protocol DelegateDatasource <UITableViewDelegate, UITableViewDataSource>
@end

@implementation DataDisplayManagerTests

- (void) setUp {
	[super setUp];
	
	CellConfiguration configuration;
	
	configuration.imageSize = CGSizeMake (kFeedImageSizeWidth, kFeedImageSizeHeight);
	configuration.basicHeight = kBasicFeedHeight;
	configuration.extendedHeight = kExtendedFeedHeight;
	
	self.manager = [MainFeedDataDisplayManager new];
	self.manager.store = OCMProtocolMock(@protocol(DataConverterStore));
	self.mockTableView = OCMClassMock([UITableView class]);
	self.manager.tableView = self.mockTableView;
	self.manager.cellConfiguration = configuration;
}

- (void) tearDown {
	
	self.manager = nil;

	[super tearDown];
}

- (void) testHeightForRowReturnsCorrectHeight {
	
	// given
	
	self.manager.selectedRowIndex = 0;
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	
	// when
	
	CGFloat height = [self.manager tableView:self.manager.tableView heightForRowAtIndexPath:path];
	
	// then
	
	XCTAssert(height == kExtendedFeedHeight);
}

- (void) testNumberOfRowsInSectionReturnCorrectNumberOfRows {
	
	// given
	
	OCMStub ([self.manager.store totalFeeds]).andReturn (5);
	
	// when
	
	NSUInteger count = [self.manager tableView:self.manager.tableView numberOfRowsInSection:0];
	
	// then
	
	XCTAssert (count == 5);
	
}

- (void) testCellForRowAtIndexPath {
	
	// given
	
	FeedCellModel *model = [FeedCellModel new];
	FeedCell* cell = OCMClassMock([FeedCell class)];
	
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	
	OCMStub ([self.manager.store feedAtIndex:0]).andReturn (model);
	OCMStub ([self.manager.tableView dequeueReusableCellWithIdentifier:kFeedCellIdentifier forIndexPath:path]).andReturn (cell);
	OCMStub ([cell configureWithFeed:OCMOCK_ANY]);
	// when
	
	cell = (FeedCell *)[self.manager tableView:self.manager.tableView cellForRowAtIndexPath:path];
	
	// then
	
	XCTAssert (cell != nil);
}

@end
