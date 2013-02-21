//
//  ShowDetailViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "ShowDetailViewController.h"
#import "IIViewDeckController.h"
#import "UIView+CRAdditions.h"
#import "Show.h"
#import "InteractionsController.h"
#import "InteractionsController+Movement.h"
#import "CRErrorView.h"
#import "UIColor+CRAdditions.h"
#import "CharlieRoseAPIClient.h"
#import "UIFont+CRAdditions.h"
#import "UIApplication+CRAdditions.h"
#import "UIDevice+CRAdditions.h"

@interface ShowDetailViewController ()<InteractionsControllerFullViewTapDelegate>

@property(nonatomic, readwrite, strong) NSString* currentShowID;

@property(nonatomic, readwrite, strong) NSDateFormatter *dateFormatter;

@property(nonatomic, readwrite, strong) IBOutlet UIScrollView* contentScrollView;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* headlineLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* guestsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* topicsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* publishingDateLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIImageView* showImageView;
@property(nonatomic, readwrite, strong) IBOutlet UITextView* descriptionTextView;

@property(nonatomic, readwrite, strong) IBOutlet UIButton* playButton;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playVideo:(id)sender;
- (IBAction)didSwipeRight:(id)sender;

@end

@implementation ShowDetailViewController

- (id)init {
    self = [self initWithShow:nil];
    if (self) {
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [_dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        
    }
    return self;
}

- (id)initWithShow:(Show *)show {
    self = [super initWithNibName:nil bundle:nil];
    if (!self) {
        return nil;
    }
    _show = show;
    
    
        
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    self.headlineLabel.font = [UIFont detailHeadlineLabelFont];
    self.guestsLabel.font = [UIFont detailGuestsLabelFont];
    self.topicsLabel.font = [UIFont detailTopicsLabelFont];
    self.publishingDateLabel.font = [UIFont detailPublishingDataLabelFont];
    self.descriptionTextView.font = [UIFont detailDescriptionTextViewFont];
    
    // hide the decription text view if older than iPhone5
    if (NO == UIDevice.isIphone5) {
        [self.descriptionTextView removeFromSuperview];
        self.descriptionTextView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideo:(id)sender {
    NSURL *url = [CharlieRoseAPIClient videoURLForShowId:self.show.showID];
    self.moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.moviePlayer];
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:NO];
}

- (void) playbackStateChanged:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    if (player.playbackState == MPMoviePlaybackStatePaused) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
        [player.view removeFromSuperview];
    }
}

#pragma mark - setters

- (void)setupHeadlineLabelWithShow:(Show *)show {
	self.headlineLabel.backgroundColor = [UIColor clearColor];
	self.headlineLabel.text = show.headline;
	self.headlineLabel.textColor = [UIColor headlineLabelTextColor];
}

- (void)setupGuestsLabelWithShow:(Show *)show {
	self.guestsLabel.backgroundColor = [UIColor clearColor];
	self.guestsLabel.text = show.guests;
	self.guestsLabel.textColor = [UIColor guestsLabelTextColor];
}

- (void)setupTopicsLabelWithShow:(Show *)show {
	self.topicsLabel.backgroundColor = [UIColor clearColor];
	self.topicsLabel.text = [NSString stringWithFormat:@"in %@", show.topics];
	self.topicsLabel.textColor = [UIColor topicsLabelTextColor];
}

- (void)setupPublishingDateLabelWithShow:(Show *)show {
    NSString *dateString = [self.dateFormatter stringFromDate:show.datePublished];
	self.publishingDateLabel.backgroundColor = [UIColor clearColor];
	self.publishingDateLabel.text = [NSString stringWithFormat:@"on %@",dateString];
	self.publishingDateLabel.textColor = [UIColor publishingDateTextColor];
}

- (void)setupDescriptionTextViewWithShow:(Show *)show {
	self.descriptionTextView.backgroundColor = [UIColor clearColor];
	self.descriptionTextView.text = show.clipDescription;
	self.descriptionTextView.textColor = [UIColor descriptionTextViewTextColor];
}

- (void)setupImageViewWithShow:(Show *)show {
    NSURL* thumbURL = [NSURL URLWithString:show.imageURL];
    __weak UIImageView* blockImageView = self.showImageView;
    [blockImageView setImageWithURL:thumbURL
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              blockImageView.alpha = .0f;
                              [UIView animateWithDuration:0.5f animations:^{
                                  blockImageView.alpha = 1.0f;
                              }];
                          }];

}

- (void)setShow:(Show *)show {
	_show = show;
	if (show) {
		[self setupHeadlineLabelWithShow:show];
		[self setupGuestsLabelWithShow:show];
		[self setupTopicsLabelWithShow:show];
		[self setupPublishingDateLabelWithShow:show];
		[self setupDescriptionTextViewWithShow:show];
        [self setupImageViewWithShow:show];
	}
}

#pragma mark - high level show

- (void)presentWithShow:(Show*)show {
	BOOL showIdTheSameAsCurrent = ([self.show.showID compare:show.showID]==NSOrderedSame);
	if (self.show.showID!=nil && showIdTheSameAsCurrent) {
		return;
	}
    
    self.show = show;
}

- (UIView*)superViewForLoadingView {
	return self.contentScrollView;
}

#pragma mark - UIGestureRecognizer delegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (IBAction)didSwipeRight:(id)sender {
    [[UIApplication sharedInteractionsController] reactToSwipeOnShowDetailViewController];
}

- (IBAction)didTapOnView:(id)sender {
    [[UIApplication sharedInteractionsController] reactToTapOnShowDetailViewController];
}

@end
