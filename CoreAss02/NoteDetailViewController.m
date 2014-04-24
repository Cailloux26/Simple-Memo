//
//  NoteDetailViewController.m
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "AppDelegate.h"

@interface NoteDetailViewController ()

@end

@implementation NoteDetailViewController
@synthesize titleText,noteText,noteid;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView {
    [super loadView];
    
    // title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(24, 61, 49, 21)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Lato-Bold" size:22];
    title.text = @"title";
    title.textColor = [self hexToUIColor:@"ffffff" alpha:1];
    UIColor *color = [UIColor grayColor];
    title.layer.shadowColor = [color CGColor];
    title.layer.shadowRadius = 3.0f;
    title.layer.shadowOpacity = 1;
    title.layer.shadowOffset = CGSizeZero;
    title.layer.masksToBounds = NO;
    self.navigationItem.titleView = title;
    
    //NavigationBar
    UIImage *navBGImage = [UIImage imageNamed:@"header_bg.png"];
    CGFloat width = 320;
    CGFloat height = 44;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [navBGImage drawInRect:CGRectMake(0, 0, width, height)];
    navBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // title
    titleText = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
    // note
    CGRect rect = CGRectMake(50, 150, 300, 200);
    noteText = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:titleText];
    [self.view addSubview:noteText];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary *dictionary = [appDelegate.noteArray objectAtIndex:noteid];
	titleText.text = [dictionary objectForKey:@"title"];
	noteText.text = [(NSDate *)[dictionary objectForKey:@"note"] description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*) hexToUIColor:(NSString *)hex alpha:(CGFloat)a{
	NSScanner *colorScanner = [NSScanner scannerWithString:hex];
	unsigned int color;
	[colorScanner scanHexInt:&color];
	CGFloat r = ((color & 0xFF0000) >> 16)/255.0f;
	CGFloat g = ((color & 0x00FF00) >> 8) /255.0f;
	CGFloat b =  (color & 0x0000FF) /255.0f;
	//NSLog(@"HEX to RGB >> r:%f g:%f b:%f a:%f\n",r,g,b,a);
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
