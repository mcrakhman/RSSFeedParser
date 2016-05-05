
#ifndef MainFeedInteractor_h
#define MainFeedInteractor_h

#import "MainFeedInteractorInput.h"
#import "MainFeedInteractorOutput.h"
#import "RSSFeedParser.h"
#import "RSSFeedParserService.h"

@interface MainFeedInteractor : NSObject <MainFeedInteractorInput, RSSFeedParserServiceOutput>

@property (nonatomic, weak, readwrite) id <MainFeedInteractorOutput> presenter;
@property (nonatomic, strong, readwrite) id <RSSFeedParserService> service;

@end

#endif /* MainFeedInteractor_h */
