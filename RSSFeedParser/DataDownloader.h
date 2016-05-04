
#ifndef DataDownloader_h
#define DataDownloader_h

@protocol DataDownloader <NSObject>

- (void) downloadDataForUrlString:(NSString *) url withBlock:(void (^) (NSData*, NSError*)) block;

@end

#endif /* DataDownloader_h */
