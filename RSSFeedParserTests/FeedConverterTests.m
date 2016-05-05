
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "FeedPlainObject.h"
#import "FeedCellModel.h"
#import "FeedConverter.h"
#import "InDateFormatter.h"
#import "OutDateFormatter.h"

@interface FeedConverterTests : XCTestCase

@property (nonatomic, strong, readwrite) FeedConverter *converter;
@property (nonatomic, strong, readwrite) id mockConverterDelegate;

@end

@implementation FeedConverterTests

- (void)setUp {
	
    [super setUp];
	
	self.converter = [FeedConverter new];
	self.converter.dateReceiverFormatter = OCMProtocolMock(@protocol(InDateFormatter));
	self.converter.stringReceiverFormatter = OCMProtocolMock(@protocol(OutDateFormatter));
	self.mockConverterDelegate = OCMProtocolMock(@protocol(FeedConverterDelegate));
	self.converter.delegate = self.mockConverterDelegate;
}

- (void)tearDown {
	
	self.mockConverterDelegate = nil;
	self.converter = nil;
	
    [super tearDown];
}

- (void) testNSDataConversionToUIImage {
	
	// given
	
	UIImage* startingImage = [UIImage imageNamed:@"islandsmall.jpg"];
	NSData* data = UIImageJPEGRepresentation (startingImage, 0.5);
	
	CellConfiguration configuration;
	configuration.imageSize = CGSizeMake (100, 100);
	
	OCMStub ([self.mockConverterDelegate getCellConfiguration]).andReturn (configuration);
	
	// when
	
	UIImage* convertedImage = [self.converter convertNSDataToImageDependingOnCellConfiguration:data];
	
	// then
	
	XCTAssert (convertedImage != nil && convertedImage.size.width == 130);
}

- (void) testConvertingFeedPlainObjectToFeedCellModel {
	// given
	
	UIImage* startingImage = [UIImage imageNamed:@"islandsmall.jpg"];
	NSData* data = UIImageJPEGRepresentation (startingImage, 0.5);
	
	CellConfiguration configuration;
	configuration.imageSize = CGSizeMake (100, 100);
	
	NSString *stringDate = @"2016-05-02 10:00:00";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSDate *testDate = [dateFormatter dateFromString:stringDate];
	
	OCMStub ([self.mockConverterDelegate getCellConfiguration]).andReturn (configuration);
	OCMStub ([self.converter.dateReceiverFormatter dateFromString:OCMOCK_ANY]).andReturn (testDate);
	OCMStub ([self.converter.stringReceiverFormatter stringFromDate:OCMOCK_ANY]).andReturn (stringDate);
	
	FeedPlainObject *object = [FeedPlainObject new];
	object.dateStringRepresentation = [stringDate mutableCopy];
	object.feedOrigin = [@"Gazeta" mutableCopy];
	object.title = [@"Title" mutableCopy];
	object.feedDescription = [@"Description" mutableCopy];
	object.imageData = data;
	
	// when
	
	FeedCellModel* model = [self.converter convertFeed:object];
	
	// then
	
	XCTAssert ([model.title isEqualToString:@"Title"]);
	XCTAssert ([model.feedDescription isEqualToString:@"Description"]);
	XCTAssert ([model.feedOrigin isEqualToString:@"Gazeta"]);
	XCTAssert ([model.dateString isEqualToString:@"2016-05-02 10:00:00"]);
	XCTAssert ([model.date isEqualToDate:testDate]);
	XCTAssert (model.image.size.width == 130);
}

@end
