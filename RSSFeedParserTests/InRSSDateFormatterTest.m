
#import <XCTest/XCTest.h>
#import "InRSSDateFormatter.h"

@interface InRSSDateFormatterTest : XCTestCase

@property (strong, nonatomic) NSDate *testDate;
@property (strong, nonatomic) InRSSDateFormatter *dateFormatter;

@end

@implementation InRSSDateFormatterTest

- (void)setUp {
    [super setUp];
	
	self.dateFormatter = [InRSSDateFormatter new];
	
	NSString *stringDate = @"2016-05-02 10:00:00";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	self.testDate = [dateFormatter dateFromString:stringDate];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertingPubDateToCorrectNSDate {
	
	// given
	NSDate *expectedDate = self.testDate;
	NSString *examplePubDate = @"Mon, 02 May 2016 10:00:00 +0300";
	NSDate *actualDate = nil;
	
	// when
	actualDate = [self.dateFormatter dateFromString:examplePubDate];
	
	// then
	XCTAssert([actualDate compare:expectedDate] == NSOrderedSame);
}

@end
