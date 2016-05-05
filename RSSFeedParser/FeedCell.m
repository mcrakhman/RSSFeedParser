
#import "FeedCell.h"

@implementation FeedCell: UITableViewCell

- (void) configureWithFeed:(FeedCellModel *)feed {
	
	// setting image
	
	if (feed.image == nil) {
		self.feedImageView.hidden = YES;
	} else {
		self.feedImageView.image = [UIImage imageWithCGImage:feed.image.CGImage];
		self.feedImageView.contentMode = UIViewContentModeScaleAspectFit;
		self.feedImageView.hidden = NO;
	}
	
	// updating constraints depending on cell configuration
	
	self.imageWidthConstraint.constant = feed.cellConfiguration.imageSize.width;
	self.imageHeightConstraint.constant = feed.cellConfiguration.imageSize.height;
	
	// setting labels
	
	self.feedTitleLabel.text = [NSString stringWithString: feed.title];
	self.feedDateLabel.text = [NSString stringWithString: feed.dateString];
	self.feedOriginLabel.text = [NSString stringWithString: feed.feedOrigin];
	
	if (feed.cellConfiguration.state == kCellExtended) {
		self.feedDescriptionLabel.text = [NSString stringWithString: feed.feedDescription];
		self.feedDescriptionLabel.hidden = false;
	} else {
		self.feedDescriptionLabel.hidden = true;
	}
	
}

@end
