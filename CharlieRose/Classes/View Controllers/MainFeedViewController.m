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
#import "Show.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CharlieRoseAPIClient.h"


static const CGFloat kHeightForRowAtIndexPath = 120.0f;

@interface MainFeedViewController ()<NSFetchedResultsControllerDelegate>

- (void)refetchData;

@property(nonatomic, strong, readwrite) NSFetchedResultsController* fetchedResultsController;

@property(nonatomic, strong, readwrite) IBOutlet UILabel* titleLabel;
@property(nonatomic, strong, readwrite) IBOutlet UITableView* tableView;
@property(nonatomic, strong, readwrite) NSString* currentTopic;

@property(nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;

@end

@implementation MainFeedViewController

- (NSFetchRequest*)fetchRequestWithTopic:(NSString*)topic {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Show"];

    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date_published" ascending:NO selector:@selector(compare:)];
    
#warning replce this with real topic --> predicate mapping
    if (topic != nil && [topic caseInsensitiveCompare:@"Home"] != NSOrderedSame) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"topics contains[cd] %@", @"Technology"];
        [fetchRequest setPredicate:predicate];
    }
    
    fetchRequest.sortDescriptors = @[dateDescriptor];
    fetchRequest.returnsObjectsAsFaults = NO;
    return fetchRequest;
}

- (void)refetchData {
    self.fetchedResultsController.fetchRequest.resultType = NSManagedObjectResultType;
    [self.fetchedResultsController performFetch:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    // create new fetched results controller and perform fetch
	NSFetchRequest *fetchRequest = [self fetchRequestWithTopic:self.currentTopic];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
	if (show.date_published) {
		cell.publishingDate = [self.dateFormatter stringFromDate:show.date_published];
	}
	[self triggerImageLoadingForCell:cell];
}


#pragma mark - resource loading
-(void)triggerImageLoadingForCell:(ShowCell*)cell {
	Show* show = cell.show;
	NSString* currentShowId = show.show_id_string;
	NSURL* url = [CharlieRoseAPIClient imageURLForShowId:currentShowId];
    if (show.imageURL) {
        url = [NSURL URLWithString:show.imageURL];
    }    
	[self triggerLoadingImageAtURL:url forImageView:cell.showImageView];
}

-(void)triggerLoadingImageAtURL:(NSURL*)url forImageView:(UIImageView*)imageView {
    __block NSURL* blockThumbURL = url;
    __block UIImageView* blockImageView = imageView;
    
    [blockImageView setImageWithURL:blockThumbURL
                   placeholderImage:nil
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              blockImageView.alpha = .0f;
                              [UIView animateWithDuration:0.5f animations:^{
                                  blockImageView.alpha = 1.0f;
                              }];
                          }];
}

- (Show*)showForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [_fetchedResultsController objectAtIndexPath:indexPath];
	return (Show*)managedObject;
}

#pragma mark - loading view
- (UIView*)superViewForLoadingView {
	return self.tableView;
}

#pragma mark - show topic

- (NSString*)titleForTopic:(NSString*)topic {
    
#warning rewrite this using topic -> title mapping
    
    NSString* newTitle = @"";
    if ([topic caseInsensitiveCompare:@"HOME"]==NSOrderedSame) {
        newTitle = @"latest charlie rose shows";
    } else {
        newTitle = [NSString stringWithFormat:@"topic: %@",topic];
    }
    return [newTitle uppercaseString];
}

- (void)showTopic:(NSString*)topic {
	BOOL topicTheSameAsCurrentTopic = ([self.currentTopic compare:topic]==NSOrderedSame);
	if (self.currentTopic!=nil && topicTheSameAsCurrentTopic) {
		return;
	}
	self.currentTopic = topic;
    self.titleLabel.text = [self titleForTopic:topic];
	[self loadDataForForTopic:self.currentTopic];
}

- (void)loadDataForForTopic:(NSString*)topic {
	
    self.currentTopic = topic;
    
#warning replace this with real handling
    
    NSFetchRequest* newFetchRequest = [self fetchRequestWithTopic:topic];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:newFetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
	if (TRUE) {
		[self loadDataForTheFirstTimeForTopic:topic];
	}
	
	if (FALSE) {
		[self loadLatestDataForTopic:topic];
	}
	
	if (FALSE) {
		[self loadMoreDataForTopic:topic];
	}
}

- (void)loadDataForTheFirstTimeForTopic:(NSString*)topic {
    self.currentTopic = topic;
    
	[self showLoadingViewAnimated:YES];
	int64_t delayInSeconds = 1.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[self hideLoadingViewAnimated:YES];
	});
}

- (void)loadLatestDataForTopic:(NSString*)topic {
}

- (void)loadMoreDataForTopic:(NSString*)topic {
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - show feed for different topic

- (void)showFeedForTopic:(NSString*)topicString {
}

@end
