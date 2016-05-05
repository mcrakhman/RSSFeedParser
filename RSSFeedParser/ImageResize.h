
#ifndef ImageResize_h
#define ImageResize_h
#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage*) resizeScaleAspectFit: (CGSize) size;

@end

#endif /* ImageResize_h */
