
#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "ImageResize.h"

@interface ImageResizeTests : XCTestCase

@end

@implementation ImageResizeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDimensionsOfImageAfterResize {
	
	// given
	UIImage* testedImage = [UIImage imageNamed:@"islandsmall.jpg"];
	
	// testing different cases when ratio between width and height
	// is greater or lower than the original ratio
	CGSize sizeWithGreaterRatio = CGSizeMake (100, 10);
	CGSize sizeWithLowerRatio = CGSizeMake (10, 100);
	
	// when
	
	UIImage* newImageWithGreaterRatio = [testedImage resizeScaleAspectFit:sizeWithGreaterRatio];
	UIImage* newImageWithLowerRatio = [testedImage resizeScaleAspectFit:sizeWithLowerRatio];
	
	// then
	
	XCTAssert(newImageWithGreaterRatio.size.height == 10);
	XCTAssert(newImageWithLowerRatio.size.width == 10);
}


@end
