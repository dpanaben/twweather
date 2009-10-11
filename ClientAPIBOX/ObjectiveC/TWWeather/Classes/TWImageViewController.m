//
//  TWImageViewController.m
//  TWWeather
//
//  Created by zonble on 2009/08/01.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import "TWImageViewController.h"


@implementation TWImageViewController

- (void)dealloc
{
	[_image release];
	_image = nil;
	[self viewDidUnload];
    [super dealloc];
}
- (void)viewDidUnload
{
	self.imageView = nil;
	self.view = nil;
}
- (void)loadView 
{
	UIScrollView *view = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)] autorelease];
	view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;	
	view.backgroundColor = [UIColor blackColor];
	view.canCancelContentTouches = NO;
	view.clipsToBounds = YES; 
	view.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	view.minimumZoomScale = 1;
	view.maximumZoomScale = 2.5;
	view.scrollEnabled = YES;
	view.delegate = self;
	view.userInteractionEnabled = YES;
	self.view = view;
	
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	imageView.backgroundColor = [UIColor blackColor];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView = imageView;
	[view setContentSize:self.imageView.frame.size];
	[view addSubview:imageView];
}

- (IBAction)copy:(id)sender
{
	UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
	pasteBoard.image = self.image;
}

#pragma mark UIViewContoller Methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.imageView.image = self.image;
	[(UIScrollView *)self.view setContentSize:_imageView.frame.size];
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Copy", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(copy:)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
}
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
//	self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated 
{
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//	self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidDisappear:(BOOL)animated 
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; 
	// Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)setImage:(UIImage *)image
{
	id tmp = _image;
	_image = [image retain];
	[tmp release];
	self.imageView.image = image;
}
- (UIImage *)image
{
	return _image;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _imageView;
}

@synthesize imageView = _imageView;
@dynamic image;

@end
