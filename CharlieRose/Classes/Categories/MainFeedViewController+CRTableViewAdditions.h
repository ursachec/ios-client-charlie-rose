//
//  MainFeedViewController+CRTableViewAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MainFeedViewController.h"


@class ShowCell;
@class Show;

@interface MainFeedViewController (CRTableViewAdditions)

#pragma mark - table view cells instanstiation
-(UITableViewCell*)newCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier;
- (ShowCell*)newShowCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier;

#pragma mark - table view helpers
-(NSString*)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - table view cells configuration
-(void)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)configureShowCell:(ShowCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - resource loading
- (Show*)showForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)triggerImageLoadingForCell:(ShowCell*)cell;
    
@end
