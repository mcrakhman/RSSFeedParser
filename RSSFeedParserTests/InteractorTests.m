
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MainFeedInteractor.h"
#import "RSSFeedParserService.h"

@interface InteractorTests : XCTestCase

@property (nonatomic, strong) MainFeedInteractor *interactor;

@property (nonatomic, strong) id mockPresenter;
@property (nonatomic, strong) id mockService;

@end

@implementation InteractorTests

- (void)setUp {
    [super setUp];
	
	self.interactor = [MainFeedInteractor new];
	self.mockPresenter = OCMProtocolMock(@protocol(MainFeedInteractorOutput));
	self.interactor.presenter = self.mockPresenter;
	
	self.mockService = OCMProtocolMock(@protocol(RSSFeedParserService));
	self.interactor.service = self.mockService;
}

- (void)tearDown {
	
	self.mockPresenter = nil;
	self.interactor = nil;
	
    [super tearDown];
}

- (void)testFindFeedsServiceFunctionExecution {
	
	// given
	
	// when
	
	[self.interactor startSearchingForRSSFeeds];
	
	// then
	
	OCMVerify([self.mockService findFeeds]);
}

- (void)testShowFeedPresenterFunctionExecution {
	
	// given
	
	FeedPlainObject* testFeed = [FeedPlainObject new];
	
	// when
	
	[self.interactor didDownloadFeed:testFeed];
	
	// then
	
	OCMVerify([self.mockPresenter showFeed:testFeed]);
}

- (void)testErrorOccuredPresenterFunctionExecution {
	
	// given
	
	NSError* error = [NSError new];
	
	// when
	
	[self.interactor errorDidOccur:error];
	
	// then
	
	OCMVerify([self.mockPresenter showError:error]);
}

@end
