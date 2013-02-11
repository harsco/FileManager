//
//  HomeScreenViewController.h
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfraFilesViewController.h"

@interface HomeScreenViewController : UIViewController
{
    IBOutlet UIButton* metalsButton;
    IBOutlet UIButton* infraButton;
}

@property(nonatomic,retain)IBOutlet UIButton* metalsButton;
@property(nonatomic,retain)IBOutlet UIButton* infraButton;

-(IBAction)onMetalsButtonClicked:(id)sender;
-(IBAction)onInfraButtonClicked:(id)sender;

@end
