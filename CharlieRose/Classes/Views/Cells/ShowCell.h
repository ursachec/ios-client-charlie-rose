//
//  ShowCell.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Show;

@interface ShowCell : UITableViewCell

@property(nonatomic, strong) UIView *cellContentView;
@property(nonatomic, strong) UIImageView *showImageView;

@property(nonatomic, strong) NSString *headline;
@property(nonatomic, strong) NSString *guests;
@property(nonatomic, strong) NSString *topics;
@property(nonatomic, strong) NSString *publishingDate;

@property(nonatomic, strong) Show* show;

@end
