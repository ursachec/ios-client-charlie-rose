//
//  AboutViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "AboutViewController.h"
#import "UIFont+CRAdditions.h"
#import "InteractionsController+Movement.h"
#import "UIApplication+CRAdditions.h"

@interface AboutViewController ()<InteractionsControllerFullViewTapDelegate>
@property(nonatomic,readwrite,strong) IBOutlet UIScrollView* contentScrollView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* aboutTheProgramTitleLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* aboutTheProgramDescriptionTextView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* aboutTheAppLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* aboutTheAppDescriptionTextView;
@end

@implementation AboutViewController

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
    
    self.aboutTheProgramTitleLabel.font = [UIFont aboutTheProgramTitleLabelFont];
    self.aboutTheProgramDescriptionTextView.font = [UIFont aboutTheProgramDescriptionTextViewFont];
    self.aboutTheAppLabel.font = [UIFont aboutTheAppLabelFont];
    self.aboutTheAppDescriptionTextView.font = [UIFont aboutTheProgramDescriptionTextViewFont];
    
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
    [[UIApplication sharedInteractionsController] reactToTapOnAboutViewController];
}

@end
