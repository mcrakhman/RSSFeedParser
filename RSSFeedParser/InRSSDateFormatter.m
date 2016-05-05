
#import <Foundation/Foundation.h>

#import "InRSSDateFormatter.h"
#import "DateFormatterConstants.h"

@implementation InRSSDateFormatter: NSObject


- (id)init {
	
	if (self = [super init]) {
		self.rssDateFormatter = [NSDateFormatter new];
		[self.rssDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:kRssStandardLocale]];
		[self.rssDateFormatter setDateFormat:kRssStandardDateFormat];
	}
	
	return self;
}

- (NSDate *)dateFromString:(NSString *)string {
	return [self.rssDateFormatter dateFromString: string];
}

@end