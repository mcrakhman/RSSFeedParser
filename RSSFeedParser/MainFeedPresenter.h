
#ifndef MainFeedPresenter_h
#define MainFeedPresenter_h

#import "MainFeedInteractorOutput.h"
#import "MainFeedInteractorInput.h"
#import "MainFeedViewInput.h"
#import "MainFeedViewOutput.h"

@interface MainFeedPresenter: NSObject <MainFeedInteractorOutput, MainFeedViewOutput>

@property (nonatomic, strong, readwrite) id <MainFeedInteractorInput> interactor;
@property (nonatomic, weak, readwrite) id <MainFeedViewInput> userInterface;
@property (nonatomic, readwrite) CellConfiguration cellConfiguration;

@end

#endif /* MainFeedPresenter_h */
