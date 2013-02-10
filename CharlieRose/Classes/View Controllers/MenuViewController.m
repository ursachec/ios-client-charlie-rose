//
//  MenuViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MenuViewController.h"
#import "IIViewDeckController.h"
#import "TopicCell.h"
#import "MenuCell.h"
#import "UIApplication+CharlieRoseAdditions.h"
#import "UIView+CharlieRoseAdditions.h"
#import "MenuViewController+CRConfigurationData.h"
#import "InteractionsController+Movement.h"

const NSInteger static kSectionTopics = 0;
const NSInteger static kSectionMenuItems = 1;

const NSInteger static kIndexForSettings = 0;
const NSInteger static kIndexForAbout = 1;
const NSInteger static kIndexForContact = 2;


@interface MenuViewController ()
@property(nonatomic,readwrite,strong) IBOutlet UITableView* tableView;
@property(nonatomic,readwrite,strong) NSArray* sections;
@property(nonatomic,readwrite,strong) NSArray* menuItems;
@property(nonatomic,readwrite,strong) NSArray* topics;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
		_sections = self.appSections;
		_menuItems = self.appMenuItems;
        _topics = self.appTopics;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger numberOfRowsInSection = 0;
	if (section==kSectionMenuItems) {
		numberOfRowsInSection = self.menuItems.count;
	} else if (section==kSectionTopics) {
		numberOfRowsInSection = self.topics.count;
	}
    return numberOfRowsInSection;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView* headerView = nil;
	if (section==kSectionMenuItems) {
		headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 10.0f)];
		headerView.backgroundColor = [UIColor redColor];
		headerView.opaque = YES;
	}
	
	return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section==kSectionMenuItems) {
		return @"";
	}
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString* currentIdentifier = [self cellIdentifierForRowAtIndexPath:indexPath];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentIdentifier];
    if (cell == nil) {
        cell = [self newCellForRowAtIndexPath:indexPath identifier:currentIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section==kSectionMenuItems) {
		return 10.0f;
	}
	return 0.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	[self configureCell:cell forRowAtIndexPath:indexPath];
}

-(void)showMenuItemAtRow:(NSInteger)row {
	if (row==kIndexForAbout) {
		[[UIApplication sharedInteractionsController] showAboutAnimated:YES];
	} else if (row==kIndexForContact) {
		[[UIApplication sharedInteractionsController] showContactAnimated:YES];
	} else if (row==kIndexForSettings) {
		[[UIApplication sharedInteractionsController] showSettingsAnimated:YES];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == kSectionMenuItems) {
		[self showMenuItemAtRow:indexPath.row];
	}
	else if (indexPath.section == kSectionTopics) {
		NSString* currentTopic = self.topics[indexPath.row];
		[[UIApplication sharedInteractionsController] showMainFeedWithTopic:currentTopic];
	}
}

#pragma mark - table view helpers
-(NSString*)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifierDefault = @"Cell";
	static NSString *CellIdentifierMenu = @"MenuCell";
	static NSString *CellIdentifierTopic = @"TopicCell";
	NSString* currentIdentifier = nil;
	if (indexPath.section==kSectionTopics) {
		currentIdentifier = CellIdentifierTopic;
	} else if (indexPath.section==kSectionMenuItems) {
		currentIdentifier = CellIdentifierMenu;
	} else {
		currentIdentifier = CellIdentifierDefault;
	}
	return currentIdentifier;
}

#pragma mark - table view cells instanstiation

-(UITableViewCell*)newCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier {
	UITableViewCell *cell = nil;
	if (indexPath.section==kSectionTopics) {
		cell = [self newTopicCellForRowAtIndexPath:indexPath identifier:identifier];
	} else if (indexPath.section==kSectionMenuItems) {
		cell = [self newMenuCellForRowAtIndexPath:indexPath identifier:identifier];
	} else {
		cell =	[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	return cell;
}

-(TopicCell*)newTopicCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier {
	TopicCell *cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	return cell;
}

-(MenuCell*)newMenuCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString*)identifier {
	MenuCell *cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	return cell;
}

#pragma mark - table view cells configuration

-(void)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section==kSectionTopics && [cell isKindOfClass:[TopicCell class]]) {
		[self configureTopicCell:(TopicCell*)cell forRowAtIndexPath:indexPath];
	} else if (indexPath.section==kSectionMenuItems && [cell isKindOfClass:[MenuCell class]]) {
		[self configureMenuCell:(MenuCell *)cell forRowAtIndexPath:indexPath];
	} else {
		NSLog(@"no configure cell");
	}
}

-(void)configureTopicCell:(TopicCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.topic = self.topics[indexPath.row];
}

-(void)configureMenuCell:(MenuCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.menuItemTitle = self.menuItems[indexPath.row];
}

@end
