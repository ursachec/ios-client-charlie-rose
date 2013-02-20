//
//  ContactViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "ContactViewController.h"
#import "UIFont+CRAdditions.h"
#import "UIApplication+CRAdditions.h"

@interface ContactViewController ()
@property(nonatomic,readwrite,strong) IBOutlet UIScrollView* contentScrollView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* contactCharlieRoseIncTitleLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* contactCharlieRoseIncDetailTextView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* contactDeveloperTitleLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* contactDeveloperDetailTextView;
@end

@implementation ContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
    
    self.contactCharlieRoseIncTitleLabel.font = [UIFont contactCharlieRoseIncTitleFont];
    self.contactCharlieRoseIncDetailTextView.font = [UIFont contactCharlieRoseIncDetailFont];
    self.contactDeveloperTitleLabel.font = [UIFont contactDeveloperTitleFont];
    self.contactDeveloperDetailTextView.font = [UIFont contactDeveloperDetailFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)superViewForLoadingView {
	return self.contentScrollView;
}

- (IBAction)didTapOnView:(id)sender {
    [[UIApplication sharedInteractionsController] reactToTapOnContactViewControllerView];
}

@end
