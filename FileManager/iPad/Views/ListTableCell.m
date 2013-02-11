//
//  ListTableCell.m
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "ListTableCell.h"

@implementation ListTableCell
@synthesize fileName;
@synthesize downloadButton;
@synthesize cellImage;
@synthesize progressBar;
@synthesize fileSize;
@synthesize downloadLabel;
@synthesize activity;
@synthesize buttonLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initVars];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initVars
{
    UIImage *myImage = [[UIImage imageNamed:@"list_item_bg"] stretchableImageWithLeftCapWidth:160
                                                                                 topCapHeight:25];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:myImage];
    myImageView.frame = self.frame;
    [self setBackgroundView:myImageView];
    [myImageView release];
    //    self.selectionStyle = UITableViewCellSelectionStyleGray;
    //    self.textLabel.backgroundColor = [UIColor clearColor];
    //    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}


@end
