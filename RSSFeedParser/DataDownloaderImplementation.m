
#import <Foundation/Foundation.h>
#import "DataDownloaderImplementation.h"

@implementation DataDownloaderImplementation: NSObject

- (void) downloadDataForUrlString:(NSString *)url withBlock:(void (^)(NSData *, NSError*))block {
	
	NSURL *nsUrl = [NSURL URLWithString: url];
	if (!nsUrl) {
		NSError* error = [NSError errorWithDomain:@"Неправильный URL адрес для скачивания данных" code:kCFErrorHTTPBadURL userInfo:nil];
		
		block (nil, error);
	}
	
	void (^dataBlock) (NSData *data, NSURLResponse *response, NSError *error) = ^(NSData *data, NSURLResponse *response, NSError *error) {
		
		block (data, error);
		
		return;
	};
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
	NSURLSessionDataTask* task = [session dataTaskWithURL:nsUrl completionHandler:dataBlock];
	
	[task resume];
	[session finishTasksAndInvalidate];
}

@end
