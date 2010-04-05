#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) 
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = 0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	// http://iphonedevelopment.blogspot.com/2010/04/converting-iphone-apps-to-universal.html
	// http://iphonedevelopment.blogspot.com/2010/04/few-more-notes-on-creating-universal.html
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		retVal = UIApplicationMain(argc, argv, nil, @"TWIPadAppDelegate");
	else 
#else
		retVal = UIApplicationMain(argc, argv, nil, @"TWWeatherAppDelegate");
#endif
    [pool release];
    return retVal;
}
