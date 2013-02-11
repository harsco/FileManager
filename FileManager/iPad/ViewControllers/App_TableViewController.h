//
//  App_TableViewController.h
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableCell.h"
#import "DataSource.h"
#import "VZAnimatedView.h"

@interface App_TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* filelistView;
    IBOutlet UINavigationBar* header;
    
    NSMutableArray* dataArray;
    
    VZAnimatedView *hudAnimatedView;
}

@property(nonatomic,retain)UITableView* filelistView;
@property(nonatomic,retain)UINavigationBar* header;


- (void)showHUD:(NSString *)message;
- (void)dismissHUD;
@end
