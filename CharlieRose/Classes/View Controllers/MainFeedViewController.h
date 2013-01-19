//
//  MainFeedViewController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CharlieRoseViewController.h"

@interface MainFeedViewController : CharlieRoseViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>
@property(nonatomic,readonly,strong) UITableView* tableView;
@property(nonatomic,readonly,strong) NSString* currentTopic;

- (void)showTopic:(NSString*)topic;

- (NSFetchRequest*)fetchRequestWithTopic:(NSString*)topic;

- (void)showFeedForTopic:(NSString*)topicString;

@end
