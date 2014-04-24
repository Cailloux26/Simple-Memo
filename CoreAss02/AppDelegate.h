//
//  AppDelegate.h
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *viewController;
@property (nonatomic, retain) NSMutableArray *noteArray;

- (NSString *)documentPath;
- (void)recoverArray;
- (void)saveArray;

@end
