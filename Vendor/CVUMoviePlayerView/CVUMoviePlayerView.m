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

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    self.videoPlayerPlaceholderImageView.image = placeholderImage;
    _placeholderImage = placeholderImage;
}

#pragma mark - private view setup methods

- (void)initVideoPlayerPlaceholderViewWithFrame:(CGRect)frame
                               placeholderImage:(UIImage*)placeholderImage {
    CGRect placeholderViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _videoPlayerPlaceholderView = [[UIView alloc] initWithFrame:placeholderViewFrame];
    _videoPlayerPlaceholderView.backgroundColor = [UIColor greenColor];
    
    CGRect placeholderImageViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _videoPlayerPlaceholderImageView = [[UIImageView alloc] initWithFrame:placeholderImageViewFrame];
    _videoPlayerPlaceholderImageView.image = placeholderImage;
    _videoPlayerPlaceholderImageView.backgroundColor = [UIColor clearColor];
    [_videoPlayerPlaceholderView addSubview:_videoPlayerPlaceholderImageView];
    
    CGSize playButtonSize = CGSizeMake(50, 50);
    CGRect playButtonFrame = CGRectMake((frame.size.width - playButtonSize.width) / 2, (frame.size.height - playButtonSize.height) / 2, playButtonSize.width , playButtonSize.height ) ;
    _videoPlayerPlaceholderPlayVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoPlayerPlaceholderPlayVideoButton.frame = playButtonFrame;
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
