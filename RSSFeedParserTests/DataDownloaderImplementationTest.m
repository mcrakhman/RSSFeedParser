
#import <XCTest/XCTest.h>
#import "DataDownloaderImplementation.h"

@interface DataDownloaderImplementationTest : XCTestCase

@property (nonatomic, strong, readwrite) DataDownloaderImplementation* downloader;

@end

@implementation DataDownloaderImplementationTest

- (void)setUp {
    [super setUp];

	self.downloader = [DataDownloaderImplementation new];
}

- (void)tearDown {
	
	self.downloader = nil;
	
	[super tearDown];
}

- (void) testFileDownload {
	
	// given
	
	NSString* pictureURL = @"https://en.wikipedia.org/wiki/File:An_illustration_of_the_dining_philosophers_problem.png";
	
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@"Download took longer than 10 secs"];
	
	// when
	
	[self.downloader downloadDataForUrlString:pictureURL withBlock:^(NSData* data, NSError* error) {
	
		// then
		
		XCTAssertNotNil(data);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
