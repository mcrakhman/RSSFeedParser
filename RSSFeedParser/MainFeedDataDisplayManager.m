
#import <Foundation/Foundation.h>
#import "MainFeedDataDisplayManager.h"
#import "FeedCell.h"

static NSInteger const kDefaultSelectedRowIndex = -1;

@implementation MainFeedDataDisplayManager: NSObject

#pragma mark - DataDisplayManager methods

- (void) setTableView: (UITableView *)tableView andCellConfiguration:(CellConfiguration)configuration {
	
	self.tableView = tableView;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	// setting first index as -1 to avoid any mistakes
	self.selectedRowIndex = kDefaultSelectedRowIndex;
	
	self.cellConfiguration = configuration;
}

- (void) addFeed: (FeedPlainObject *)feed {
	
	[self.store addFeed:feed];
	
	__weak typeof (self) welf = self;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[welf.tableView reloadData];
	});
	
}

#pragma mark - UITableViewDelegate methods

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row == self.selectedRowIndex) {
		return self.cellConfiguration.extendedHeight;
	} else {
		return self.cellConfiguration.basicHeight;
	}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	self.selectedRowIndex = self.selectedRowIndex != indexPath.row ? indexPath.row : kDefaultSelectedRowIndex;
	[tableView reloadData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.store totalFeeds];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	FeedCell *cell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:kFeedCellIdentifier forIndexPath:indexPath];

	FeedCellModel* model = [self.store feedAtIndex:indexPath.row];
	
	if (model != nil) {
		
		CellConfiguration newConfiguration = self.cellConfiguration;
		CellState currentState = indexPath.row == self.selectedRowIndex ? kCellExtended : kCellNormal;
		newConfiguration.state = currentState;
		
		model.cellConfiguration = newConfiguration;
		[cell configureWithFeed:model];
	}
	
	return cell;
}

#pragma mark - FeedConverterDelegate methods

- (CellConfiguration)getCellConfiguration {
	return self.cellConfiguration;
}

@end