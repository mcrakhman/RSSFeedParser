
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** 
 Class represents Rss feed object data
 */
@interface FeedPlainObject : NSObject

@property (nonatomic, strong, readwrite) NSMutableString* title;
@property (nonatomic, strong, readwrite) NSMutableString* feedDescription;
@property (nonatomic, strong, readwrite) NSMutableString* dateStringRepresentation;
@property (nonatomic, strong, readwrite) NSData* imageData;
@property (nonatomic, strong, readwrite) NSString* imageUrlString;
@property (nonatomic, strong, readwrite) NSString* feedOrigin;

@end
