
#ifndef InRSSDateFormatter_h
#define InRSSDateFormatter_h

#import "InDateFormatter.h"

@interface InRSSDateFormatter : NSObject <InDateFormatter>

@property (nonatomic, strong, readwrite) NSDateFormatter* rssDateFormatter;

- (id) init;

@end

#endif /* InRSSDateFormatter_h */
