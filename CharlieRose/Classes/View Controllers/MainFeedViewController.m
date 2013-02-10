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
    NSString *topic = @"all";
    [self fetchDataForTopic:topic success:^(NSFetchedResultsController *controller) {
        if (controller.fetchedObjects.count == 0) {
            [self networkImportShowsForTopic:topic success:success failure:failure];
        } else {
            success();
        }
    } failure:^(NSFetchedResultsController *controller, NSError *error) {
        failure(error);
    }];
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
#warning TODO: implement method
    NSLog(@"showCouldNotContactServer");
//    [self showLoadingViewAnimated:YES];
    [self showErrorViewAnimated:YES message:@"COULD NOT CONTACT SERVER"];
}

- (void)showViewForCoreDataError {
#warning TODO: implement method
    NSLog(@"showViewForCoreDataError");
    
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

- (void)showTopic:(NSString*)topic {
	BOOL topicTheSameAsCurrentTopic = ([self.currentTopic compare:topic]==NSOrderedSame);
	if (self.currentTopic!=nil && topicTheSameAsCurrentTopic) {
		return;
	}
	self.currentTopic = topic;
    self.titleLabel.text = [MainFeedViewController titleForTopic:topic];
	[self fetchDataForTopic:self.currentTopic
                    success:^(NSFetchedResultsController *controller) {
                        [self.tableView reloadData];
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
        
#warning handle errors
        
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	     */
	    abort();
	}
    
    success(self.fetchedResultsController);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
