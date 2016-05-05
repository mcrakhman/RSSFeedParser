
#ifndef OutRussianDateFormatter_h
#define OutRussianDateFormatter_h

#import "OutDateFormatter.h"

@interface OutRussianDateFormatter : NSObject <OutDateFormatter>

@property (nonatomic, strong, readwrite) NSDateFormatter* russianDateFormatter;

- (id) init;

@end

#endif /* OutRussianDateFormatter_h */
