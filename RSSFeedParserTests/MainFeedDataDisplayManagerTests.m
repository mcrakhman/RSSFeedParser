
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CellConfigurationConstants.h"
#import "MainFeedDataDisplayManager.h"
#import "ViewController.h"

@interface MainFeedDataDisplayManagerTests : XCTestCase

@property (nonatomic, strong, readwrite) MainFeedDataDisplayManager *manager;
@property (nonatomic, strong, readwrite) ViewController *viewController;

@end

@implementation MainFeedDataDisplayManagerTests

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
	[self.manager setTableView:self.viewController.tableView andCellConfiguration:configuration];
}

- (void) tearDown {
	
	self.manager = nil;
	self.viewController = nil;
	
    [super tearDown];
}

- (void) testThatCreatedViewControllerIsNotNil {
	XCTAssert(self.viewController != nil);
}

@end
