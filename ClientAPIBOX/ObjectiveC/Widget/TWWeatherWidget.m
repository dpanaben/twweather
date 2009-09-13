//
//  TWWeatherWidget.m
//  WeatherWidget
//
//  Created by zonble on 2009/09/13.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import "TWWeatherWidget.h"


@implementation TWWeatherWidget

- (void)dealloc
{
	_webView = nil;
	[super dealloc];
}
- (id)initWithWebView:(WebView *)webview
{
	self = [super init];
	if (self != nil) {
		_webView = webview;
	}
	return self;
}
- (void)windowScriptObjectAvailable:(WebScriptObject*)webScriptObject 
{
    [webScriptObject setValue:self forKey:@"WeatherPlugin"];
}
#pragma mark -
#pragma mark WebScripting

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector 
{
    return NO;
}

+ (NSString *)webScriptNameForSelector:(SEL)selector
{
	return selName;
}


@end
