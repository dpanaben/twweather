//
//  TWTwitterEngine.h
//  TWWeather
//
//  Created by zonble on 1/19/10.
//  Copyright 2010 Lithoglyph Inc.. All rights reserved.
//

#import "MGTwitterEngine.h"

@interface TWTwitterEngine : MGTwitterEngine
{
	BOOL isLoggedIn;
}

@property (assign, getter=isLoggedIn) BOOL loggedIn;

@end
