
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Typhoon/Typhoon.h>
#import "CellConfigurationConstants.h"
#import "MainFeedDataDisplayManager.h"
#import "ViewController.h"

@interface DataDisplayManagerTests : XCTestCase

@property (nonatomic, strong, readwrite) MainFeedDataDisplayManager *manager;
@property (nonatomic, strong, readwrite) ViewController *viewController;

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
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
	[self.viewController view];
	[self.manager setTableView:self.viewController.tableView andCellConfiguration:configuration];
}

- (void) tearDown {
	
	self.manager = nil;
	self.viewController = nil;
	
	[super tearDown];
}

- (void) testHeightForRow {
	
	// given
	
	self.manager.selectedRowIndex = 0;
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	
	// when
	
	CGFloat height = [self.manager tableView:self.manager.tableView heightForRowAtIndexPath:path];
	
	// then
	
	XCTAssert(height == kExtendedFeedHeight);
}

- (void) testNumberOfRowsInSection {
	
	// given
	
	OCMStub ([self.manager.store totalFeeds]).andReturn (1);
	
	// when
	
	NSUInteger count = [self.manager tableView:self.manager.tableView numberOfRowsInSection:0];
	
	// then
	
	XCTAssert (count == 1);
	
}

- (void) testCellForRowAtIndexPath {
	
	// given
	
	FeedCellModel *model = [FeedCellModel new];
	model.dateString = @"2 мая 2015 года 10:00";
	model.feedOrigin = @"Gazeta";
	model.title = @"Title";
	model.feedDescription = @"Description";
	
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	
	OCMStub ([self.manager.store feedAtIndex:0]).andReturn (model);
	
	// when
	
	FeedCell* cell = (FeedCell *)[self.manager tableView:self.manager.tableView cellForRowAtIndexPath:path];
	
	// then
	
	XCTAssert (cell != nil);
}

@end
