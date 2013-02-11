//
//  ListTableCell.h
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableCell : UITableViewCell
{
    IBOutlet UILabel* fileName;
    IBOutlet UILabel* fileSize;
    IBOutlet UILabel* downloadLabel;
    IBOutlet UILabel* buttonLabel;
    IBOutlet UIButton* downloadButton;
    IBOutlet UIImageView* cellImage;
    IBOutlet UIProgressView* progressBar;
    
    IBOutlet UIActivityIndicatorView* activity;
}

@property(nonatomic,retain)IBOutlet UILabel* fileName;
@property(nonatomic,retain)IBOutlet UILabel* fileSize;
@property(nonatomic,retain)IBOutlet UILabel* downloadLabel;
@property(nonatomic,retain)IBOutlet UILabel* buttonLabel;
@property(nonatomic,retain)IBOutlet UIButton* downloadButton;
@property(nonatomic,retain)IBOutlet UIImageView* cellImage;
@property(nonatomic,retain)IBOutlet UIProgressView* progressBar;

@property(nonatomic,retain)IBOutlet UIActivityIndicatorView* activity;


@end
