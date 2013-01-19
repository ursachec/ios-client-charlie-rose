//
//  MenuViewController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CharlieRoseViewController.h"

@interface MenuViewController : CharlieRoseViewController <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,readonly,strong) UITableView* tableView;
@end
