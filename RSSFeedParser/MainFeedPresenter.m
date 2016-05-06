
#import <Foundation/Foundation.h>
#import "MainFeedPresenter.h"
#import "MainFeedInteractor.h"
#import "CellConfigurationConstants.h"

@implementation MainFeedPresenter: NSObject

- (id) init {
	if (self = [super init]) {
		self.cellConfiguration = kBasicCellConfiguration;
	}
	
	return self;
}

#pragma mark - MainFeedViewOutput methods

- (void)didTriggerViewReadyEvent {
	
	[self.userInterface setupInitialStateWithCellConfiguration: self.cellConfiguration];
	[self.interactor startSearchingForRSSFeeds];
}

#pragma mark - MainFeedInteractorOutput methods

- (void) showFeed:(FeedPlainObject *)feed {
	[self.userInterface updateDataForDisplayManager:feed];
}

- (void) showError:(NSError *)error {
	[self.userInterface showAlertWithError:error];
}

@end
