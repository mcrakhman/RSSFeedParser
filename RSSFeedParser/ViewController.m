

#import "ViewController.h"
#import "CellConfigurationConstants.h"

@interface ViewController ()

@property (nonatomic, readwrite) BOOL isErrorShowing;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.isErrorShowing = false;
	
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - MainViewInput methods

/**
 Provides the feed to the display manager 
 */
- (void) updateDataForDisplayManager:(FeedPlainObject *)feed {
	[self.manager addFeed:feed];
}

/**
 Shows alert on any error occured. As of this version, it does not analyze the errors based on the NSError object
 */

- (void) showAlertWithError:(NSError *)error {
	
	// prevent more than 1 error to show up
	if (self.isErrorShowing) {
		return;
	}
	
	self.isErrorShowing = true;
	
	__weak typeof(self) welf = self;
	
	UIAlertController * alert = [UIAlertController
								 alertControllerWithTitle:@"Ошибочка"
								 message:@"Какая-то ошибка а работе приложения, даже и не знаю, что еще сказать..."
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

/**
 Starts the data display manager
 */

- (void) setupInitialStateWithCellConfiguration: (CellConfiguration) cellConfiguration {
	[self.manager setTableView:self.tableView andCellConfiguration:cellConfiguration];
}

@end