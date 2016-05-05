
#import <UIKit/UIKit.h>
#import "RSSFeedParser.h"
#import "MainFeedPresenter.h"
#import "FeedDataConverterStore.h"
#import "DataDisplayManager.h"
#import "MainFeedViewInput.h"
#import "MainFeedViewOutput.h"

@interface ViewController : UIViewController <MainFeedViewInput>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, readwrite) id <MainFeedViewOutput> output;
@property (nonatomic, strong, readwrite) id <DataDisplayManager> manager;

@end

