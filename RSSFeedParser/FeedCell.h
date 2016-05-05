
#import <UIKit/UIKit.h>

#import "FeedCellModel.h"

static NSString *const kFeedCellIdentifier = @"FeedCell";

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *feedTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedOriginLabel;
@property (weak, nonatomic) IBOutlet UIStackView *cellStackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;

- (void) configureWithFeed: (FeedCellModel *) feed;

@end
