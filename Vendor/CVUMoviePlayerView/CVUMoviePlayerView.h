//
//  CVUMoviePlayerView.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVUMoviePlayerView : UIView

@property(nonatomic, strong, readonly) UIView* videoPlayerPlaceholderView;
@property(nonatomic, strong, readonly) UIImageView* videoPlayerPlaceholderImageView;
@property(nonatomic, strong, readonly) UIButton* videoPlayerPlaceholderPlayVideoButton;
@property(nonatomic, strong, readwrite) UIImage* placeholderImage;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
           videoURL:(NSURL*)videoURL;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage;

@end
