//
//  RSSFeedParserOutput.h
//  ObjCTest
//
//  Created by MIKHAIL RAKHMANOV on 03.05.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#ifndef RSSFeedParserOutput_h
#define RSSFeedParserOutput_h

#import "FeedPlainObject.h"

@protocol RSSFeedParserServiceOutput <NSObject>

- (void) didDownloadFeed: (FeedPlainObject *) feed;
- (void) errorDidOccur: (NSError *) error;

@end

#endif /* RSSFeedParserOutput_h */
