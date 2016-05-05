

#import "ViewController.h"
#import "CellConfigurationConstants.h"

@interface ViewController ()

@property (nonatomic, readwrite) BOOL isErrorShowing;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.isErrorShowing = false;
	
	//[self configureTableView];
	//[self.output getFeeds];
}

- (void)viewDidAppear: (BOOL) animated {
	[super viewDidAppear:animated];
	
}

#pragma mark - private methods

- (void) configureTableView {
	CellConfiguration configuration;
	
	configuration.imageSize = CGSizeMake (kFeedImageSizeWidth, kFeedImageSizeHeight);
	configuration.basicHeight = kBasicFeedHeight;
	configuration.extendedHeight = kExtendedFeedHeight;
	
	[self.manager setTableView:self.tableView andCellConfiguration:configuration];
}

#pragma mark - MainViewOutput methods

- (void) updateDataForDisplayManager:(FeedPlainObject *)feed {
	[self.manager addFeed:feed];
}

- (void) showAlertWithError:(NSError *)error {
	
	if (self.isErrorShowing) {
		return;
	}
	
	self.isErrorShowing = true;
	
	__weak typeof(self) welf = self;
	
	UIAlertController * alert = [UIAlertController
								 alertControllerWithTitle:@"Ошибочка"
								 message:@"Какая-то ошибка а работе, даже и не знаю, что сказать..."
								 preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* action = [UIAlertAction
							 actionWithTitle:@"Я понял!"
							 style:UIAlertActionStyleDefault
							 handler:^(UIAlertAction * action)
							 {
								 welf.isErrorShowing = false;
								 [alert dismissViewControllerAnimated:YES completion:nil];
								 
							 }];
	[alert addAction:action];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[welf presentViewController:alert animated:NO completion:nil];
	});
}


@end