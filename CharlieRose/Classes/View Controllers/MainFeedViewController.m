//
//  MainFeedViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MainFeedViewController.h"
#import "ShowCell.h"
#import "IIViewDeckController.h"
#import "UIApplication+CharlieRoseAdditions.h"
#import "UIView+CharlieRoseAdditions.h"

#import "CharlieRoseAPIClient.h"

#import "NSError+CRAdditions.h"
#import "NSString+CRAdditions.h"
#import "NSFetchedResultsController+CRAdditions.h"

#import "Show.h"
#import "CRDBHandler.h"

#import "MainFeedViewController+CRTableViewAdditions.h"
#import "MainFeedViewController+CRConfigurationData.h"
#import "InteractionsController+Movement.h"

#import "NSUserDefaults+CRAdditions.h"

static const CGFloat kHeightForRowAtIndexPath = 120.0f;

@interface MainFeedViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic, strong, readwrite) IBOutlet UILabel* titleLabel;
@property(nonatomic, strong, readwrite) IBOutlet UITableView* tableView;
@property(nonatomic, strong, readwrite) NSString* currentTopic;
@property(nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;
@end

@implementation MainFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        
        self.managedObjectContext = nil;
    }
    return self;
}

-(void)loadAllShowsFromNetworkOrDBWithSuccess:(void (^)(void))success
                                      failure:(void (^)(NSError* error))failure {
    [self fetchDataForTopic:kRemoteKeyForTopicHome success:^(NSFetchedResultsController *controller) {
        if (controller.fetchedObjects.count == 0) {
            [self initialNetworkImportWithSuccess:success failure:failure];
        } else {
            success();
        }
    } failure:^(NSFetchedResultsController *controller, NSError *error) {
        failure(error);
    }];
}

- (void)initialNetworkImportWithSuccess:(void (^)(void))success
                                failure:(void (^)(NSError* error))failure {
    if ([CharlieRoseAPIClient sharedClient].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        failure(error);
    } else {
        [self networkImportShowsForTopic:kRemoteKeyForTopicHome success:success failure:failure];
    }
}

- (void)networkImportShowsForTopic:(NSString*)topic
                           success:(void (^)(void))success
                           failure:(void (^)(NSError* error))failure {
    [self showLoadingViewAnimated:YES];
    [[CharlieRoseAPIClient sharedClient] getShowsForTopic:topic
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      
                                                      NSError *error = nil;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            [[CRDBHandler sharedDBHandler] importShowsArray:responseObject
                                                   forTopic:topic
                                                    success:success
                                                    failure:failure];
            [self hideLoadingViewAnimated:YES];
        } else {
            failure(error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)handleDidLoadAllShowsFromNetworkOrDB {
    [UIApplication.sharedAppDelegate setHasImportedShowsForInitialImport:YES];
    [self hideLoadingViewAnimated:YES];
    [self hideErrorViewAnimated:YES];
}

- (void)handleDidFailLoadingAllShowsFromNetworkOrDBWithError:(NSError*)error {
    if ([error isNetworkingError]) {
        [self showViewForCouldNotContactServer];
    } else if ([error isCoreDataError]) {
        [self showViewForCoreDataError];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self loadAllShowsFromNetworkOrDBWithSuccess:^{
        [self handleDidLoadAllShowsFromNetworkOrDB];
    } failure:^(NSError *error) {
        [self handleDidFailLoadingAllShowsFromNetworkOrDBWithError:error];
    }];
}

- (void)showViewForCouldNotContactServer {
    [self showErrorViewAnimated:YES message:@"COULD NOT CONTACT SERVER"];
}

- (void)showViewForCoreDataError {
    [self showErrorViewAnimated:YES message:@"A BAD THING HAS ACCOURED"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kHeightForRowAtIndexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* currentIdentifier = [self cellIdentifierForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentIdentifier];
    if (cell == nil) {
        cell = [self newCellForRowAtIndexPath:indexPath identifier:currentIdentifier];
    }
    [self configureCell:cell forRowAtIndexPath:indexPath];
	[self triggerImageLoadingForCell:(ShowCell*)cell indexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	[self configureCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL isCenterControllerShown = ([self.viewDeckController rightControllerIsClosed] && [self.viewDeckController leftControllerIsClosed]);
	if (isCenterControllerShown) {
		Show* show = [self showForRowAtIndexPath:indexPath];
		[[UIApplication sharedInteractionsController] showDetailViewWithShow:show];
		
	} else {
		[self.viewDeckController showCenterView];
	}
}

#pragma mark - loading view

- (UIView*)superViewForLoadingView {
	return self.tableView;
}

#pragma mark - show topic

- (void)showTopicHome {
    [self showTopic:kLocalKeyForTopicHome];
}

- (void)showTopic:(NSString*)topic {
	BOOL topicTheSameAsCurrentTopic = ([self.currentTopic compare:topic]==NSOrderedSame);
	if (self.currentTopic!=nil && topicTheSameAsCurrentTopic) {
		return;
	}
    
    [self fetchDataAndShowFeedForTopic:topic];
}

- (void)fetchDataAndShowFeedForTopic:(NSString*)topic {
    self.currentTopic = topic;
    self.titleLabel.text = [MainFeedViewController titleForTopic:topic];
	[self fetchDataForTopic:self.currentTopic
                    success:^(NSFetchedResultsController *controller) {
                        if (UIApplication.sharedAppDelegate.hasImportedShowsForInitialImport) {
                            [self.tableView reloadData];
                            [self hideLoadingViewAnimated:YES];
                            [self hideErrorViewAnimated:YES];
                        }
                    } failure:^(NSFetchedResultsController *controller, NSError *error) {
                        [self showViewForCoreDataError];
                    }];
}

- (void)fetchDataForTopic:(NSString*)topic
                  success:(void (^)(NSFetchedResultsController* controller))success
                  failure:(void (^)(NSFetchedResultsController* controller, NSError* error ))failure {
    self.currentTopic = topic;
    
    self.fetchedResultsController = [NSFetchedResultsController fetchedResultsControllerWithTopic:topic delegate:self managedObjectContext:[CRDBHandler sharedDBHandler].insertionContext];
    
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        failure(self.fetchedResultsController, error);
	}
    
    success(self.fetchedResultsController);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
