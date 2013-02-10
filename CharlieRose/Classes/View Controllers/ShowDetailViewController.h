//
//  ShowDetailViewController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CharlieRoseViewController.h"

@class Show;

@interface ShowDetailViewController : CharlieRoseViewController <UINavigationControllerDelegate>

@property(nonatomic,readonly,strong) NSString* currentShowID;
@property(nonatomic,readonly,strong) UIScrollView* contentScrollView;

@property(nonatomic, readonly, strong) UILabel* headlineLabel;
@property(nonatomic, readonly, strong) UILabel* guestsLabel;
@property(nonatomic, readonly, strong) UILabel* topicsLabel;
@property(nonatomic, readonly, strong) UILabel* publishingDateLabel;
@property(nonatomic, readonly, strong) UIImageView* showImageView;
@property(nonatomic, readonly, strong) UITextView* descriptionTextView;

- (id)initWithShow:(Show *)show;
- (void)presentWithShow:(Show*)show;

@end
