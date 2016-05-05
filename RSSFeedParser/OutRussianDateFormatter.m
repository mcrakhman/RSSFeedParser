
#import <Foundation/Foundation.h>

#import "OutRussianDateFormatter.h"
#import "DateFormatterConstants.h"

@implementation OutRussianDateFormatter: NSObject

- (id)init {
	
	if (self = [super init]) {
		self.russianDateFormatter = [NSDateFormatter new];
		
		[self.russianDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:kRussianLocale]];
		[self.russianDateFormatter setDateFormat:kRussianDateFormat];
	}
	
	return self;
}

- (NSString *)stringFromDate:(NSDate *)date {
	return [self.russianDateFormatter stringFromDate:date];
}

@end