//
//  MainViewController.m
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableView, noteViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
    [tableView reloadData];
}

- (void)loadView {
    [super loadView];
    // Background
    UIImage *BaseImage = [UIImage imageNamed:@"backgroung.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:BaseImage];
    
    // navigation
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(24, 61, 49, 21)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Lato-Bold" size:22];
    title.text = @"Note";
    title.textColor = [self hexToUIColor:@"ffffff" alpha:1];
    UIColor *color = [UIColor grayColor];
    title.layer.shadowColor = [color CGColor];
    title.layer.shadowRadius = 3.0f;
    title.layer.shadowOpacity = 1;
    title.layer.shadowOffset = CGSizeZero;
    title.layer.masksToBounds = NO;
    self.navigationItem.titleView = title;
    UIImage *navBGImage = [UIImage imageNamed:@"header_bg.png"];
    CGFloat width = 320;
    CGFloat height = 44;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [navBGImage drawInRect:CGRectMake(0, 0, width, height)];
    navBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:navBGImage forBarMetrics:UIBarMetricsDefault];
    
    // add button
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(showNoteInputView)];
    addButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // table view
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    //tableView.editing = YES;
    [self.view addSubview:tableView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// define tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	return [appDelegate.noteArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FirstViewCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSDictionary *dictionary = [appDelegate.noteArray objectAtIndex:indexPath.row];
	cell.textLabel.text = [dictionary objectForKey:@"title"];
	cell.detailTextLabel.text = [(NSDate *)[dictionary objectForKey:@"note"] description];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // NSDictionary *listDict = [appDelegate.noteArray objectAtIndex:indexPath.row];
   // NSString *id = [listDict objectForKey:@"id"];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NoteDetailViewController *detailViewController = [[NoteDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.noteid = indexPath.row;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [appDelegate.noteArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

// add note info
- (void)showNoteInputView {
	noteViewController = [[NoteViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *NoteInputNav = [[UINavigationController alloc]init];
    NoteInputNav = [[UINavigationController alloc] initWithRootViewController:noteViewController];
    [self presentViewController:NoteInputNav animated:YES completion:nil];
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
