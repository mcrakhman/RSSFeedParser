
#import <Foundation/Foundation.h>
#import "MainFeedPresenter.h"
#import "MainFeedInteractor.h"
#import "CellConfigurationConstants.h"

@implementation MainFeedPresenter: NSObject

#pragma mark - MainFeedViewOutput methods

- (void)didTriggerViewReadyEvent {
	
	[self.userInterface setupInitialStateWithCellConfiguration: basicCellConfiguration];
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
