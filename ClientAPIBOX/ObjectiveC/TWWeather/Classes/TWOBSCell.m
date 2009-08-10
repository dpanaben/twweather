//
//  TWOBSCell.m
//  TWWeather
//
//  Created by zonble on 2009/08/08.
//

#import "TWOBSCell.h"


@interface TWOBSCell (ProtectedMethods)
- (void)draw:(CGRect)bounds;
@end

@interface TWOBSCellContentView : UIView
{
	TWOBSCell *_delegate;
}
@property (assign, nonatomic) TWOBSCell *delegate;
@end

@implementation TWOBSCellContentView

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}
- (void)drawRect:(CGRect)rect
{
	[_delegate draw:self.bounds];
}

@synthesize delegate = _delegate;
@end

@implementation TWOBSCell

- (void)dealloc
{
	[_ourContentView removeFromSuperview];
	[_ourContentView release];
	[description release];
	[rain release];
	[temperature release];
	[windDirection release];
	[windScale release];
	[gustWindScale release];
	[weatherImage release];
    [super dealloc];
}
- (void)_init
{
	CGRect cellFrame = CGRectMake(10, 10, 280, 280);
	_ourContentView = [[TWOBSCellContentView alloc] initWithFrame:cellFrame];
	_ourContentView.delegate = self;
	[self.contentView addSubview:_ourContentView];	
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self _init];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		[self _init];
    }
    return self;
}
- (void)draw:(CGRect)bounds
{
	CGSize size = weatherImage.size;
	[weatherImage drawInRect:CGRectMake(10, 20, size.width * 0.8, size.height * 0.8)];
	
	[@"天氣現象" drawInRect:CGRectMake(100, 30, 160, 20) withFont:[UIFont boldSystemFontOfSize:16.0]];
	[description drawInRect:CGRectMake(100, 70, 160, 80) withFont:[UIFont boldSystemFontOfSize:22.0]];
	
	[[NSString stringWithFormat:@"溫度: %@", temperature] drawInRect:CGRectMake(100, 130, 160, 20) withFont:[UIFont systemFontOfSize:18.0]];
	[[NSString stringWithFormat:@"累積雨量: %@ 毫米", rain] drawInRect:CGRectMake(100, 160, 160, 20) withFont:[UIFont systemFontOfSize:18.0]];
	[[NSString stringWithFormat:@"風向: %@", windDirection] drawInRect:CGRectMake(100, 190, 160, 20) withFont:[UIFont systemFontOfSize:18.0]];
	[[NSString stringWithFormat:@"風力: %@ 級", windScale] drawInRect:CGRectMake(100, 220, 160, 20) withFont:[UIFont systemFontOfSize:18.0]];
	[[NSString stringWithFormat:@"陣風: %@ 級", gustWindScale] drawInRect:CGRectMake(100, 250, 260, 20) withFont:[UIFont systemFontOfSize:18.0]];
}
	
- (void)setNeedsDisplay
{
	[_ourContentView setNeedsDisplay];
	[super setNeedsDisplay];
}

@synthesize description;
@synthesize rain;
@synthesize temperature;
@synthesize windDirection;
@synthesize windScale;
@synthesize gustWindScale;
@synthesize weatherImage;

@end
