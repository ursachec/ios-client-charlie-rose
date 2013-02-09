//
//  CRManagedTableViewController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "SSManagedTableViewController.h"

@interface CRManagedTableViewController : SSManagedTableViewController

@property(nonatomic,readonly,strong) UITableView* tableView;
@property(nonatomic,readonly,strong) NSString* currentTopic;

@end
