//
//  NoteDetailViewController.h
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteDetailViewController : UIViewController {
    UILabel *titleText;
    UILabel *noteText;
}
@property (nonatomic, retain) UILabel *titleText;
@property (nonatomic, retain) UILabel *noteText;
@property (nonatomic) NSInteger noteid;
@end
