//
//  MainFeedInteractorOutput.h
//  ObjCTest
//
//  Created by MIKHAIL RAKHMANOV on 28.04.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#ifndef MainFeedInteractorOutput_h
#define MainFeedInteractorOutput_h

#import "FeedPlainObject.h"

@protocol MainFeedInteractorOutput <NSObject>

- (void) showFeed: (FeedPlainObject *)feed;
- (void) showError: (NSError *)error;

@end

#endif /* MainFeedInteractorOutput_h */
