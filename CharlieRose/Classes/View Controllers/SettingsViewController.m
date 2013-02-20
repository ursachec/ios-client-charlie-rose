//
//  SettingsViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "SettingsViewController.h"
#import "NSUserDefaults+CRAdditions.h"
#import "UIFont+CRAdditions.h"
#import "UIApplication+CRAdditions.h"


@interface SettingsViewController ()
@property(nonatomic,readwrite,strong) IBOutlet UIScrollView* contentScrollView;
@property(nonatomic,readwrite,strong) IBOutlet UISwitch* trackingAllowedSwitch;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* explanatoryTextView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* toggleTrackingTitleLabel;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideLoadingOrErrorViewAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.trackingAllowedSwitch addTarget:self action: @selector(flip:) forControlEvents: UIControlEventValueChanged];
    
    self.toggleTrackingTitleLabel.font = [UIFont toggleTrackingTitleLabelFont];
    self.explanatoryTextView.font = [UIFont explanatoryTextViewFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)superViewForLoadingView {
	return self.contentScrollView;
}

- (void)flip:(id)sender {
    UISwitch *onoff = (UISwitch *) sender;
    [NSUserDefaults setTrackingDenied:(!onoff.isOn)];
}

- (IBAction)didTapOnView:(id)sender {    
    [[UIApplication sharedInteractionsController] reactToTapOnSettingsViewController];
}

@end
