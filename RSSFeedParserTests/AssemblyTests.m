#import <RamblerTyphoonUtils/AssemblyTesting.h>
#import <Typhoon/Typhoon.h>

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ApplicationConstants.h"
#import "ApplicationAssembly.h"
#import "MainFeedInteractor.h"
#import "MainFeedDataDisplayManager.h"
#import "DataDownloaderImplementation.h"
#import "FeedDataConverterStore.h"
#import "InRSSDateFormatter.h"
#import "OutRussianDateFormatter.h"
#import "RSSFeedParserService.h"
#import "RSSFeedParserImplementation.h"
#import "ApplicationAssembly.h"

@interface ApplicationAssemblyTests : RamblerTyphoonAssemblyTests

@property (nonatomic, strong) ApplicationAssembly *assembly;

@end

@implementation ApplicationAssemblyTests

#pragma mark - Настройка окружения для тестирования

- (void)setUp {
	[super setUp];
	
	self.assembly = [ApplicationAssembly new];
	[self.assembly activate];
}

- (void)tearDown {
	self.assembly = nil;
	
	[super tearDown];
}

#pragma mark - Тестирование создания элементов модуля

- (void)testThatAssemblyCreatesViewController {
	
	// given
	
	Class expectedClass = [ViewController class];
	NSArray *expectedProtocols = @[
								   @protocol(MainFeedViewInput)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(output),
							  RamblerSelector(manager)
							  ];
	
	// when
	
	id result = [self.assembly firstViewController];
	
	// then
	
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
	// given
	Class expectedClass = [MainFeedPresenter class];
	NSArray *expectedProtocols = @[
								   @protocol(MainFeedInteractorOutput),
								   @protocol(MainFeedViewOutput)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(interactor),
							  RamblerSelector(userInterface)
							  ];
	
	// when
	id result = [self.assembly mainPresenter];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
	// given
	Class expectedClass = [MainFeedInteractor class];
	NSArray *expectedProtocols = @[
								   @protocol(MainFeedInteractorInput),
								   @protocol(RSSFeedParserServiceOutput)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(presenter),
							  RamblerSelector(service)
							  ];
	
	// when
	id result = [self.assembly mainInteractor];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataDisplayManager {
	// given
	Class expectedClass = [MainFeedDataDisplayManager class];
	NSArray *expectedProtocols = @[
								   @protocol(DataDisplayManager),
								   @protocol(FeedConverterDelegate)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(store)
							  ];
	
	// when
	id result = [self.assembly dataManager];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesDataStore {
	// given
	Class expectedClass = [FeedDataConverterStore class];
	NSArray *expectedProtocols = @[
								   @protocol(DataConverterStore)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(converter)
							  ];
	
	// when
	id result = [self.assembly dataStore];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesFeedConverter {
	// given
	Class expectedClass = [FeedConverter class];
	NSArray *expectedProtocols = @[
								   @protocol(DataConverter)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(dateReceiverFormatter),
							  RamblerSelector(stringReceiverFormatter),
							  RamblerSelector(delegate)
							  ];
	
	// when
	id result = [self.assembly feedConverter];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRSSFeedParserService {
	// given
	Class expectedClass = [GazetaLentaRSSFeedParserService class];
	NSArray *expectedProtocols = @[
								   @protocol(RSSFeedParserService)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(lentaParser),
							  RamblerSelector(gazetaParser),
							  RamblerSelector(downloader),
							  RamblerSelector(output)
							  ];
	
	// when
	id result = [self.assembly rssFeedParserService];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesLentaRSSFeedParser {
	// given
	Class expectedClass = [RSSFeedParserImplementation class];
	NSArray *expectedProtocols = @[
								   @protocol(RSSFeedParser)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(delegate),
							  RamblerSelector(elementOrigin),
							  RamblerSelector(feedUrlString)
							  ];
	
	// when
	id result = [self.assembly lentaRSSParser];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}

- (void)testThatAssemblyCreatesGazetaRSSFeedParser {
	// given
	Class expectedClass = [RSSFeedParserImplementation class];
	NSArray *expectedProtocols = @[
								   @protocol(RSSFeedParser)
								   ];
	RamblerTyphoonAssemblyTestsTypeDescriptor *resultTypeDescriptor =
	[RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:expectedClass
													  andProtocols:expectedProtocols];
	NSArray *dependencies = @[
							  RamblerSelector(delegate),
							  RamblerSelector(elementOrigin),
							  RamblerSelector(feedUrlString)
							  ];
	
	// when
	id result = [self.assembly gazetaRSSParser];
	
	// then
	[self verifyTargetDependency:result
				  withDescriptor:resultTypeDescriptor
					dependencies:dependencies];
}


@end