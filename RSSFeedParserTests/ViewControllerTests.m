//
//  ViewControllerTests.m
//  RSSFeedParser
//
//  Created by MIKHAIL RAKHMANOV on 05.05.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"

@interface ViewControllerTests : XCTestCase

@property (nonatomic, strong, readwrite) ViewController *viewController;
@property (nonatomic, strong, readwrite) id mockOutput;
@property (nonatomic, strong, readwrite) id mockManager;

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
	[self.viewController view];

	self.mockOutput = OCMProtocolMock(@protocol(MainFeedViewOutput));
	self.mockManager = OCMProtocolMock(@protocol(DataDisplayManager));
	self.viewController.output = self.mockOutput;
	self.viewController.manager = self.mockManager;
}

- (void)tearDown {
	
	self.mockOutput = nil;
	self.viewController = nil;
	self.mockManager = nil;
	
    [super tearDown];
}

- (void) testThatOutputGetFeedsIsCalledAfterViewDidLoad {
	
	// given
	
	// when
	
	[self.viewController viewDidLoad];
	
	// then
	
	OCMVerify([self.mockOutput getFeeds]);
	
}

- (void) testThatMangerAddFeedIsCalledAfterUpdateData {
	
	// given
	
	// when
	
	[self.viewController updateDataForDisplayManager:OCMOCK_ANY];
	
	// then
	
	OCMVerify([self.mockManager addFeed:OCMOCK_ANY]);
	
}

@end