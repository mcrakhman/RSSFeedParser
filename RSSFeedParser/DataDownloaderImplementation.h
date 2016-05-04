
#ifndef ImageDataDownloader_h
#define ImageDataDownloader_h

#import "DataDownloader.h"

/**
 This is a class that does only one thing - download an image or other file via NSURLDataTask
 */
@interface DataDownloaderImplementation : NSObject <DataDownloader>
@end

#endif /* ImageDataDownloader_h */
