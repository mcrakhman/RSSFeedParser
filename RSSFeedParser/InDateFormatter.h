
#ifndef InDateFormatter_h
#define InDateFormatter_h

@protocol InDateFormatter <NSObject>

- (NSDate*) dateFromString: (NSString*) string;

@end

#endif /* InDateFormatter_h */
