//
//  NoteViewController.m
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "NoteViewController.h"
#import "AppDelegate.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize titleTextField, noteTextView, InputtableView, singleTap, navigationBar, saveButton, noteinfo;


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
    title.text = @"Input Note";
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
    
    
    // cancel button
    UIBarButtonItem* CancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    CancelButton.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:navBGImage forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = CancelButton;
    // save button
    UIBarButtonItem* SaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    SaveButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = SaveButton;
    
    // table view
    InputtableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    InputtableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    InputtableView.dataSource = self;
    InputtableView.delegate = self;
    [self.view addSubview:InputtableView];
    
    // input email
    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    titleTextField.textColor = [UIColor blueColor];
    titleTextField.placeholder = @"title";
    titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    // input note
    CGRect rect = CGRectMake(0, 0, 300, 200);
    noteTextView = [[UITextView alloc]initWithFrame:rect];
    noteTextView.editable = YES;
    noteTextView.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	noteTextView.font = [UIFont systemFontOfSize:18.0];
    
    // define single tap gesture to close keyboard
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];

    noteinfo = [[NSMutableDictionary alloc]init];
    
}

// single tap recognizer
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer{

    [titleTextField resignFirstResponder];
    [noteTextView resignFirstResponder];
}
// singletap works only when keyboard opens.
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == singleTap) {
        if (titleTextField.isFirstResponder || noteTextView.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	[self.titleTextField becomeFirstResponder];
}

// define table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if (section == 0) {
		return @"title";
	}
	else if (section == 1) {
		return @"note";
	}
	return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 0) {
		return 44.0;
	} else if (indexPath.section == 1) {
		return 88.0;
	}
	return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"EntryCell";
    UITableViewCell *cell = [InputtableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	if (indexPath.section == 0) {
		CGRect frame =  self.titleTextField.frame;
		frame.origin.x = 10.0;
		self.titleTextField.frame = frame;
		[cell.contentView addSubview:titleTextField];
	}
	else if (indexPath.section == 1) {
		[cell.contentView addSubview:noteTextView];
	}
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	if ([string length] > 0) {
		self.saveButton.enabled = YES;
	}
	else {
		self.saveButton.enabled = NO;
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
	
	NSDate *date = [NSDate date];
    
	// ID
	srand(time(nil));
	int num = rand() % 100;
	int sec = (double)[date timeIntervalSince1970];
	NSString *anId = [NSString stringWithFormat:@"%d%d", sec, num];
	[noteinfo setObject:anId forKey:@"id"];
    NSLog(@"%@",anId);
    // save title and note to documentPath.
    [noteinfo setObject:titleTextField.text forKey:@"title"];
	[noteinfo setObject:noteTextView.text forKey:@"note"];
    NSLog(@"%@",titleTextField.text);
    //save
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.noteArray addObject:noteinfo];
	[appDelegate saveArray];

    // close
	[self dismissViewControllerAnimated:YES completion:nil];
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
