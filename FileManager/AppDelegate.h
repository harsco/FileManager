//
//  AppDelegate.h
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreenViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property(strong,nonatomic)HomeScreenViewController* homeScreen;

@end
