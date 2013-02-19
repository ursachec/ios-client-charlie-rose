//
//  PrivacyPolicyViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 19.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import "UIFont+CRAdditions.h"

@interface PrivacyPolicyViewController ()
@property(nonatomic,readwrite,strong) IBOutlet UITextView* privacyPolicyTextView;
@end

@implementation PrivacyPolicyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.privacyPolicyTextView.font = [UIFont privacyPolicyTextViewFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
