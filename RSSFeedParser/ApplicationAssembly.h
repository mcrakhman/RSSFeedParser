
#ifndef ApplicationAssembly_h
#define ApplicationAssembly_h

#import <Typhoon/Typhoon.h>
#import "AppDelegate.h"

@interface ApplicationAssembly : TyphoonAssembly

- (id) firstViewController;
- (id) mainPresenter;
- (id) mainInteractor;
- (id) lentaRSSParser;
- (id) gazetaRSSParser;
- (id) dataManager;
- (id) dataStore;
- (id) feedConverter;
- (id) rssFeedParserService;

@end


#endif /* ApplicationAssembly_h */
