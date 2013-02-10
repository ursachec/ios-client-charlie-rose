//
//  MainFeedViewController+CRTableViewAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MainFeedViewController+CRTableViewAdditions.h"
#import "ShowCell.h"
#import "Show.h"
#import "CharlieRoseAPIClient.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MainFeedViewController (CRTableViewAdditions)

#pragma mark - table view cells instanstiation

-(UITableViewCell*)newCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier {
	UITableViewCell *cell = nil;
	cell = [self newShowCellForRowAtIndexPath:indexPath identifier:identifier];
	return cell;
}

- (ShowCell*)newShowCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier {
	ShowCell *cell = [[ShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	return cell;
}

#pragma mark - table view helpers
-(NSString*)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifierShowCell = @"ShowCell";
	NSString* currentIdentifier = nil;
	currentIdentifier = CellIdentifierShowCell;
	return currentIdentifier;
}

#pragma mark - table view cells configuration

-(void)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	[self configureShowCell:(ShowCell *)cell forRowAtIndexPath:indexPath];
}

-(void)configureShowCell:(ShowCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	Show* show = [self showForRowAtIndexPath:indexPath];
    cell.show = show;
	if (show.datePublished) {
		cell.publishingDate = [self.dateFormatter stringFromDate:show.datePublished];
	}
	[self triggerImageLoadingForCell:cell indexPath:indexPath];
}

#pragma mark - resource loading

- (Show*)showForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	return (Show*)managedObject;
}

-(void)triggerImageLoadingForCell:(ShowCell*)cell indexPath:(NSIndexPath *)indexPath {
	Show* show = cell.show;
	NSURL* url = [CharlieRoseAPIClient imageURLForShowId:show.showID];
    if (show.imageURL) {
        url = [NSURL URLWithString:show.imageURL];
    }
    [self setImageWithURL:url forCell:cell indexPath:indexPath];
}

- (void)setImageWithURL:(NSURL*)url forCell:(ShowCell*)cell indexPath:(NSIndexPath *)indexPath {
    __weak UIImageView* weakImageView = cell.imageView;
    [cell.imageView setImageWithURL:url
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              weakImageView.alpha = 0.0f;
                              [UIView animateWithDuration:0.5f animations:^{
                                  weakImageView.alpha = 1.0f;
                              }];
                          }];
}

@end
