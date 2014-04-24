//
//  NoteViewController.h
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate> {
    UITextField *titleTextField;
    UITextView *noteTextView;
    UINavigationBar *navigationBar;
	UIBarButtonItem *saveButton;
    UITableView *InputtableView;
    NSMutableDictionary *noteinfo;
}

@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UITextView *noteTextView;
@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) UIBarButtonItem *saveButton;
@property (nonatomic, retain) UITableView *InputtableView;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, retain) NSMutableDictionary *noteinfo;

- (void)cancel;
- (void)save;

@end
