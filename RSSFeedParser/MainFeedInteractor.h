//
//  MainFeedInteractor.h
//  ObjCTest
//
//  Created by MIKHAIL RAKHMANOV on 28.04.16.
//  Copyright © 2016 No Logo. All rights reserved.
//

#ifndef MainFeedInteractor_h
#define MainFeedInteractor_h

#import "MainFeedInteractorInput.h"
#import "MainFeedInteractorOutput.h"
#import "RSSFeedParser.h"
#import "RSSFeedParserService.h"

@interface MainFeedInteractor : NSObject <MainFeedInteractorInput, RSSFeedParserServiceOutput>

@property (nonatomic, weak, readwrite) id <MainFeedInteractorOutput> presenter;
@property (nonatomic, strong, readwrite) id <RSSFeedParserService> service;

@end

#endif /* MainFeedInteractor_h */
