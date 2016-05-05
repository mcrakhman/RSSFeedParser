
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CellConfigurationConstants.h"
#import "MainFeedDataDisplayManager.h"
#import "ViewController.h"

@interface FeedCellTests : XCTestCase

@property (nonatomic, strong, readwrite) ViewController *viewController;
@property (nonatomic, readwrite) CellConfiguration cellConfiguration;

@end

@implementation FeedCellTests

- (void) setUp {
	[super setUp];
	
	CellConfiguration configuration;
	
	configuration.imageSize = CGSizeMake (kFeedImageSizeWidth, kFeedImageSizeHeight);
	configuration.basicHeight = kBasicFeedHeight;
	configuration.extendedHeight = kExtendedFeedHeight;
	configuration.state = kCellExtended;
	
	self.cellConfiguration = configuration;
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
}

- (void) tearDown {

	self.viewController = nil;
	
	[super tearDown];
}

- (void) testThatCellIsProperlyConfiguredWithCellModel {
	
	// given
	
	FeedCellModel *model = [FeedCellModel new];
	model.dateString = @"2 мая 2015 года 10:00";
	model.feedOrigin = @"Gazeta";
	model.title = @"Title";
	model.feedDescription = @"Description";
	model.cellConfiguration = self.cellConfiguration;
	
	[self.viewController view];
	
	// when
	
	FeedCell *cell = [self.viewController.tableView dequeueReusableCellWithIdentifier:kFeedCellIdentifier];
	[cell configureWithFeed:model];
	
	// then
	
	XCTAssert([cell.feedTitleLabel.text isEqualToString:model.title]);
	XCTAssert([cell.feedDescriptionLabel.text isEqualToString:model.feedDescription]);
	XCTAssert([cell.feedDateLabel.text isEqualToString:model.dateString]);
	XCTAssert([cell.feedOriginLabel.text isEqualToString:model.feedOrigin]);
	
	XCTAssert(cell.feedDescriptionLabel.hidden == false);
	XCTAssert(cell.feedImageView.hidden == true);
	
	XCTAssert(cell.imageWidthConstraint.constant == self.cellConfiguration.imageSize.width);
	XCTAssert(cell.imageHeightConstraint.constant == self.cellConfiguration.imageSize.height);
}

@end
