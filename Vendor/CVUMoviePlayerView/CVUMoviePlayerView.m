//
//  CVUMoviePlayerView.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CVUMoviePlayerView.h"

@interface CVUMoviePlayerView ()
@property(nonatomic, strong, readwrite) UIView* videoPlayerPlaceholderView;
@property(nonatomic, strong, readwrite) UIImageView* videoPlayerPlaceholderImageView;
@property(nonatomic, strong, readwrite) UIButton* videoPlayerPlaceholderPlayVideoButton;
@property(nonatomic, strong, readwrite) UIImage* placeholderImage;
@property(nonatomic, copy, readwrite) NSURL* videoURL;
@end

@implementation CVUMoviePlayerView

- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
           videoURL:(NSURL*)videoURL
{
    self = [super initWithFrame:frame];
    if (self) {
        _videoURL = videoURL;
        
        [self initVideoPlayerPlaceholderViewWithFrame:frame placeholderImage:placeholderImage];
        [self addSubview:_videoPlayerPlaceholderView];
        
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
{
    self = [self initWithFrame:frame placeholderImage:placeholderImage videoURL:nil];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame placeholderImage:nil videoURL:nil];
    return self;
}

#pragma mark - private view setup methods

- (void)initVideoPlayerPlaceholderViewWithFrame:(CGRect)frame
                               placeholderImage:(UIImage*)placeholderImage {
    _videoPlayerPlaceholderView = [[UIView alloc] initWithFrame:frame];
    
    CGRect videoPlayerPlaceholderImageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _videoPlayerPlaceholderImageView = [[UIImageView alloc] initWithFrame:videoPlayerPlaceholderImageViewFrame];
    _videoPlayerPlaceholderImageView.image = placeholderImage;
    [_videoPlayerPlaceholderView addSubview:_videoPlayerPlaceholderImageView];
    
    CGSize videoPlayerPlaceholderPlayVideoButtonSize = CGSizeMake(50, 50);
    CGRect videoPlayerPlaceholderPlayVideoButtonFrame = CGRectMake(0, 0, (frame.size.width - videoPlayerPlaceholderPlayVideoButtonSize.width) / 2, (frame.size.height - videoPlayerPlaceholderPlayVideoButtonSize.height) / 2);
    _videoPlayerPlaceholderPlayVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoPlayerPlaceholderPlayVideoButton.frame = videoPlayerPlaceholderPlayVideoButtonFrame;
    [_videoPlayerPlaceholderPlayVideoButton addTarget:self action:@selector(didPushVideoPlayButton:) forControlEvents:UIControlEventTouchDown];
    [_videoPlayerPlaceholderView addSubview:_videoPlayerPlaceholderPlayVideoButton];
    
}

- (void)didPushVideoPlayButton:(id)sender {
    NSLog(@"didPushVideoPlayButton");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
