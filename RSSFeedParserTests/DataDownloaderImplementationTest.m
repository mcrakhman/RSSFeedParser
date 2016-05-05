
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
	
	// creating semaphore to prevent the test finishing before the respective
	// async request
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	double waitTime = 10.0;
	
	// when
	[self.downloader downloadDataForUrlString:pictureURL withBlock:^(NSData* data, NSError* error) {
		// then
		XCTAssert(error == nil && data != nil);
		NSLog(@"Data length is %lu", (unsigned long)data.length);
		
		dispatch_semaphore_signal(semaphore);
	}];
	
	dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, waitTime * NSEC_PER_SEC);
	if (dispatch_semaphore_wait (semaphore, timeout)) {
		XCTFail(@"Wait time has exceeded the prescribed limits");
	}
}

@end
