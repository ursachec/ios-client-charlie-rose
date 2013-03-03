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
#import <MessageUI/MessageUI.h>
#import "Mixpanel.h"

NSString * const kEmailClaudiu = @"claudiu@cvursache.com";
NSString * const kEmailCharlieRose = @"charlierose@pbs.org";

@interface ContactViewController () <MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate>
@property(nonatomic,readwrite,strong) IBOutlet UIScrollView* contentScrollView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* contactCharlieRoseIncTitleLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* contactCharlieRoseIncDetailTextView;
@property(nonatomic,readwrite,strong) IBOutlet UILabel* contactDeveloperTitleLabel;
@property(nonatomic,readwrite,strong) IBOutlet UITextView* contactDeveloperDetailTextView;

- (IBAction)sendEmailToCharlieRose;
- (IBAction)sendEmailToClaudiu;

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

- (void)viewDidLoad {
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

#pragma mark - mail composer
-(void)displayComposerSheetWithRecipient:(NSString*)recepient {
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
	
    NSArray *toRecipients = @[recepient];
    [controller setToRecipients:toRecipients];
    
    NSString* emailSubject = @" ";
    [controller setSubject:emailSubject];
    
    NSString *emailBody = @"";
    [controller setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentViewController:controller animated:YES completion:^{
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    NSString* resultStrings = [self mailComposeResultStringForResult:result];
    [controller dismissViewControllerAnimated:YES completion:^{
        NSString* message = [NSString stringWithFormat:@"[mail] didFinishWithResult: %@", resultStrings];
        [[Mixpanel sharedInstance] track:message];
    }];
}

#pragma mark - send email actions
- (IBAction)sendEmailToCharlieRose {
    [self displayComposerSheetWithRecipient:kEmailCharlieRose];
    NSString* message = [NSString stringWithFormat:@"[mail] presentViewController: %@", kEmailCharlieRose];
    [[Mixpanel sharedInstance] track:message];
}

- (IBAction)sendEmailToClaudiu {
    [self displayComposerSheetWithRecipient:kEmailClaudiu];
    NSString* message = [NSString stringWithFormat:@"[mail] presentViewController: %@", kEmailClaudiu];
    [[Mixpanel sharedInstance] track:message];
}

#pragma mark - mail results


- (NSString*)mailComposeResultStringForResult:(MFMailComposeResult)result {
    NSString* resultString = nil;
    switch (result) {
        case MFMailComposeResultCancelled:
            resultString = @"canceled";
            break;
        case MFMailComposeResultSaved:
            resultString = @"saved";
            break;
        case MFMailComposeResultSent:
            resultString = @"sent";
            break;
        case MFMailComposeResultFailed:
            resultString = @"failed";
            break;
    }
    return resultString;
}

@end
