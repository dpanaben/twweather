//
//  TWNearSeaTableViewController.m
//  TWWeather
//
//  Created by zonble on 2009/08/01.
//

#import "TWNearSeaTableViewController.h"
#import "TWNearSeaResultTableViewController.h"

@implementation TWNearSeaTableViewController

- (void)viewDidLoad 
{
	[super viewDidLoad];
	self.array = [[TWAPIBox sharedBox] nearSeaLocations];
	self.title = @"台灣近海天氣預報";
}

#pragma mark UITableViewDataSource and UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSMutableDictionary *dictionray = [[self array] objectAtIndex:indexPath.row];
	NSString *identifier = [dictionray objectForKey:@"identifier"];
	[[TWAPIBox sharedBox] fetchNearSeaWithLocationIdentifier:identifier delegate:self userInfo:dictionray];
	self.tableView.userInteractionEnabled = NO;
	[dictionray setObject:[NSNumber numberWithBool:YES] forKey:@"isLoading"];
	[self.tableView reloadData];
}

- (void)APIBox:(TWAPIBox *)APIBox didFetchNearSea:(id)result identifier:(NSString *)identifier userInfo:(id)userInfo
{
	[self resetLoading];
	NSLog(@"result:%@", [result description]);
	if ([result isKindOfClass:[NSDictionary class]]) {
		TWNearSeaResultTableViewController *controller = [[TWNearSeaResultTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		controller.title = [result objectForKey:@"locationName"];
		NSString *dateString = [result objectForKey:@"publishTime"];
		NSDate *date = [[TWAPIBox sharedBox] dateFromShortString:dateString];
		controller.publishTime = [[TWAPIBox sharedBox] shortDateTimeStringFromDate:date];

		dateString = [result objectForKey:@"validBeginTime"];
		date = [[TWAPIBox sharedBox] dateFromShortString:dateString];
		controller.validBeginTime = [[TWAPIBox sharedBox] shortDateTimeStringFromDate:date];

		dateString = [result objectForKey:@"validEndTime"];
		date = [[TWAPIBox sharedBox] dateFromShortString:dateString];
		controller.validEndTime = [[TWAPIBox sharedBox] shortDateTimeStringFromDate:date];
		
		controller.description = [result objectForKey:@"description"];
		controller.wave = [result objectForKey:@"wave"];
		controller.waveLevel = [result objectForKey:@"waveLevel"];
		controller.wind = [result objectForKey:@"wind"];
		controller.windLevel = [result objectForKey:@"windLevel"];
		
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}	
	self.tableView.userInteractionEnabled = YES;
}
- (void)APIBox:(TWAPIBox *)APIBox didFailedFetchNearSeaWithError:(NSError *)error identifier:(NSString *)identifier userInfo:(id)userInfo
{
	[self resetLoading];
	self.tableView.userInteractionEnabled = YES;
}


@end

