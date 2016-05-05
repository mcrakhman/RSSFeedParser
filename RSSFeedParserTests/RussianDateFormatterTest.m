
#import <XCTest/XCTest.h>
#import "OutRussianDateFormatter.h"

@interface RussianDateFormatterTest : XCTestCase

@property (strong, nonatomic) NSDate *testDate;
@property (strong, nonatomic) OutRussianDateFormatter *dateFormatter;

@end

@implementation RussianDateFormatterTest

- (void)setUp {
    [super setUp];

	self.dateFormatter = [OutRussianDateFormatter new];
	
	NSString *stringDate = @"2016-05-02 10:00:00";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	self.testDate = [dateFormatter dateFromString:stringDate];
}

- (void)tearDown {
	self.testDate = nil;
	self.dateFormatter = nil;
	
    [super tearDown];
}

- (void)testConvertingNSDateToExpectedFormat {
	
	// given
	NSString *expectedStringFromTestDate = @"02 мая 2016 10:00";
	NSString *actualStringFromTestDate = nil;
	
	// when
	actualStringFromTestDate = [self.dateFormatter stringFromDate:self.testDate];
	
	// then
	XCTAssert([actualStringFromTestDate isEqualToString:expectedStringFromTestDate]);
}


@end
