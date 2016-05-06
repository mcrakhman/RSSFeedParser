
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MainFeedPresenter.h"
#import "MainFeedInteractorInput.h"
#import "MainFeedViewInput.h"
#import "CellConfigurationConstants.h"

#define OCMOCK_STRUCT(atype, variable) [NSValue valueWithBytes:&variable withObjCType:@encode(atype)]

@interface MainFeedPresenterTests : XCTestCase

@property (nonatomic, strong, readwrite) MainFeedPresenter* presenter;
@property (nonatomic, strong, readwrite) id mockInteractor;
@property (nonatomic, strong, readwrite) id mockUserInterface;

@end

@implementation MainFeedPresenterTests

- (void)setUp {
    [super setUp];
	
	self.presenter = [MainFeedPresenter new];
	self.mockInteractor = OCMProtocolMock(@protocol(MainFeedInteractorInput));
	self.mockUserInterface = OCMProtocolMock(@protocol(MainFeedViewInput));
	self.presenter.interactor = self.mockInteractor;
	self.presenter.userInterface = self.mockUserInterface;
	
}

- (void)tearDown {

	self.mockInteractor = nil;
	self.mockUserInterface = nil;
	self.presenter = nil;
	
	[super tearDown];
}

- (void) testThatDidTriggerViewReadyEventMakesInteractorStartSearchingAndSetsUIInitialState {
	
	// given
	
	self.presenter.cellConfiguration = kBasicCellConfiguration;
	
	// when
	
	[self.presenter didTriggerViewReadyEvent];
	
	// then
	
	OCMVerify([self.mockInteractor startSearchingForRSSFeeds]);
	OCMVerify([self.mockUserInterface setupInitialStateWithCellConfiguration:kBasicCellConfiguration]);
}

- (void) testThatShowFeedsMakesInterfaceCallShowMethod {
	
	// given
	
	FeedPlainObject* testFeed = [FeedPlainObject new];
	
	// when
	
	[self.presenter showFeed:testFeed];
	
	// then
	
	OCMVerify([self.mockUserInterface updateDataForDisplayManager:testFeed]);
}

- (void) testThatShowErrorMakesInterfaceShowAlert {
	
	// given
	
	NSError* error = [NSError new];
	
	// when
	
	[self.presenter showError:error];
	
	// then
	
	OCMVerify([self.mockUserInterface showAlertWithError:error]);
}

@end
