
#ifndef FeedCellModel_h
#define FeedCellModel_h

#import <UIKit/UIKit.h>
#import "FeedPlainObject.h"
#import "CellConfiguration.h"

@interface FeedCellModel : NSObject

@property (nonatomic, strong, readwrite) NSString* title;
@property (nonatomic, strong, readwrite) NSString* feedDescription;
@property (nonatomic, strong, readwrite) UIImage* image;
@property (nonatomic, strong, readwrite) NSDate* date;
@property (nonatomic, strong, readwrite) NSString* dateString;
@property (nonatomic, strong, readwrite) NSString* feedOrigin;

@property (nonatomic, readwrite) CellConfiguration cellConfiguration;

@end


#endif /* FeedCellModel_h */
