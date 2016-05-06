
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ApplicationConstants.h"
#import "Typhoon.h"
#import "ApplicationAssembly.h"
#import "MainFeedInteractor.h"
#import "MainFeedDataDisplayManager.h"
#import "DataDownloaderImplementation.h"
#import "FeedDataConverterStore.h"
#import "InRSSDateFormatter.h"
#import "OutRussianDateFormatter.h"
#import "RSSFeedParserService.h"
#import "RSSFeedParserImplementation.h"

@implementation ApplicationAssembly


- (id) firstViewController {
	return [TyphoonDefinition withClass:[ViewController class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(output) with: [self mainPresenter]];
		[definition injectProperty:@selector(manager) with: [self dataManager]];
	}];
}

- (id) mainPresenter {
	return [TyphoonDefinition withClass:[MainFeedPresenter class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(interactor) with: [self mainInteractor]];
		[definition injectProperty:@selector(userInterface) with: [self firstViewController]];
	}];
}

- (id) mainInteractor {
	return [TyphoonDefinition withClass:[MainFeedInteractor class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(service) with: [self rssFeedParserService]];
		[definition injectProperty:@selector(presenter) with: [self mainPresenter]];
	}];
}

- (id) dataManager {
	return [TyphoonDefinition withClass:[MainFeedDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(store) with:[self dataStore]];
	}];
}

- (id) dataStore {
	return [TyphoonDefinition withClass:[FeedDataConverterStore class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(converter) with:[self feedConverter]];
	}];
}

- (id) feedConverter {
	return [TyphoonDefinition withClass:[FeedConverter class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(dateReceiverFormatter) with:[InRSSDateFormatter new]];
		[definition injectProperty:@selector(stringReceiverFormatter) with:[OutRussianDateFormatter new]];
		[definition injectProperty:@selector(delegate) with:[self dataManager]];
	}];
}

- (id) rssFeedParserService {
	return [TyphoonDefinition withClass:[GazetaLentaRSSFeedParserService class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(lentaParser) with: [self lentaRSSParser]];
		[definition injectProperty:@selector(gazetaParser) with: [self gazetaRSSParser]];
		[definition injectProperty:@selector(downloader) with: [DataDownloaderImplementation new]];
		[definition injectProperty:@selector(output) with: [self mainInteractor]];
	}];
}


- (id) lentaRSSParser {
	return [TyphoonDefinition withClass:[RSSFeedParserImplementation class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(delegate) with:[self rssFeedParserService]];
		[definition injectProperty:@selector(elementOrigin) with:kLentaRSSFeedOrigin];
		[definition injectProperty:@selector(feedUrlString) with:kLentaUrl];
	}];
}

- (id) gazetaRSSParser {
	return [TyphoonDefinition withClass:[RSSFeedParserImplementation class] configuration:^(TyphoonDefinition *definition) {
		[definition injectProperty:@selector(delegate) with:[self rssFeedParserService]];
		[definition injectProperty:@selector(elementOrigin) with:kGazetaRSSFeedOrigin];
		[definition injectProperty:@selector(feedUrlString) with:kGazetaUrl];
	}];
}

@end