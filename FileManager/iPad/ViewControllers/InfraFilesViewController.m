//
//  InfraFilesViewController.m
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "InfraFilesViewController.h"

static float filedownload;

@interface InfraFilesViewController ()

@end

@implementation InfraFilesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"App_TableViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithPath:(NSString*)folderPath
{
    if(self = [super init])
    {
        pathName = [[NSString alloc] initWithString:folderPath];
        NSLog(@"path is %@",pathName);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    filedownload = 0.0;
    
    [self showHUD:@"Fetching List Of Files"];
    
    self.header.topItem.title = pathName;
    
    dataSource = [[DataSource alloc] init];
    dataSource.delegate = self;
    [dataSource fetchInfraFilesListOfFolder:pathName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}







#pragma mark Table View Methods Override


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"indexpath is %d",indexPath.row);
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
    
    // GridCell *cell = (GridCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    ListTableCell* cell = (ListTableCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListTableCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
    
    //return cell;
}

- (void)configureCell:(ListTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fileName.text = [(file*)[dataArray objectAtIndex:indexPath.row] fileName];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg@2x.png"]] autorelease];
    cell.downloadButton.tag = indexPath.row;
    [cell.downloadButton addTarget:self action:@selector(onCellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    [cell.activity setHidden:YES];
    
    if([(file*)[dataArray objectAtIndex:indexPath.row] isFolder])
    {
         cell.cellImage.image = [UIImage imageNamed:@"leopard-folder"];
        [cell.downloadButton setHidden:YES];
        [cell.fileSize setHidden:YES];
        [cell.buttonLabel setHidden:YES];
                
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.fileSize.text = [(file*)[dataArray objectAtIndex:indexPath.row] fileSizeDisplay];
        
        if([[(file*)[dataArray objectAtIndex:indexPath.row] fileType] isEqualToString:@"mp4"])
        {
            cell.cellImage.image = [UIImage imageNamed:@"mp4"];
        }
        else if([[(file*)[dataArray objectAtIndex:indexPath.row] fileType] isEqualToString:@"pdf"])
        {
            cell.cellImage.image = [UIImage imageNamed:@"icon-PDF"];
        }
        else if([[(file*)[dataArray objectAtIndex:indexPath.row] fileType] isEqualToString:@"ppt"])
        {
            cell.cellImage.image = [UIImage imageNamed:@"ppt"];
        }
        if([[Utilities getInstance] isFileExists:[(file*)[dataArray objectAtIndex:indexPath.row] fileName]])
        {
            [cell.downloadButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [cell.buttonLabel setHidden:NO];
            [cell.buttonLabel setText:@"Open"];
        }
        
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[dataArray objectAtIndex:indexPath.row] isFolder])
    {
        InfraFilesViewController* infraVC = [[InfraFilesViewController alloc] initWithPath:[pathName stringByAppendingFormat:@"%@%@",[(file*)[dataArray objectAtIndex:indexPath.row] fileName],@"/"]];
        [self presentViewController:infraVC animated:YES completion:Nil];
    }

    
}

-(void)onCellButtonClick:(UIButton*)sender
{
    NSLog(@"cell tag is %d",sender.tag);
    
    
    if([[Utilities getInstance] isFileExists:[(file*)[dataArray objectAtIndex:sender.tag] fileName]])
    {
       
        if([[(file*)[dataArray objectAtIndex:sender.tag] fileType] isEqualToString:@"pdf"])
        {
            pdfViewer* pdfVC = [[pdfViewer alloc] initWithPDFFileName:[(file*)[dataArray objectAtIndex:sender.tag] fileName]];
            
            [self presentViewController:pdfVC animated:YES completion:Nil];
        }
        else if([[(file*)[dataArray objectAtIndex:sender.tag] fileType] isEqualToString:@"mp4"])
        {
            NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
            
            NSLog(@"path for resource is %@",resourceDocPath);
            
            NSString *filePath = [resourceDocPath stringByAppendingPathComponent:[(file*)[dataArray objectAtIndex:sender.tag] fileName]];
            NSURL *fURL = [NSURL fileURLWithPath:filePath];
        
                                    
          MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:fURL];
          [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
          [videoPlayerView.moviePlayer play];
        }
        else if([[(file*)[dataArray objectAtIndex:sender.tag] fileType] isEqualToString:@"ppt"])
        {
            pdfViewer* pdfVC = [[pdfViewer alloc] initWithPDFFileName:[(file*)[dataArray objectAtIndex:sender.tag] fileName]];
            
            [self presentViewController:pdfVC animated:YES completion:Nil];
        }
        else
        {
             [Utilities showAlertOKWithTitle:@"File Open Alert!!" withMessage:@"Currently this file format is not supported"];
        }
        
    }
    else
    {
        //currently supporting only one download
        if(!isDownloadInProgress)
        {
            indexOfFile = sender.tag;
            
            
            
            isDownloadInProgress = YES;
            [dataSource downloadFile:[(file*)[dataArray objectAtIndex:sender.tag] fileName] atFilePath:[pathName stringByAppendingFormat:@"%@%@",[(file*)[dataArray objectAtIndex:sender.tag] fileName],@"/"]];
            
            ListTableCell* cell = (ListTableCell*)[self.filelistView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
            
            [cell.downloadButton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
             [cell.buttonLabel setHidden:NO];
            [cell.buttonLabel setText:@"Cancel"];

    //        progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //        progress.frame = CGRectMake(200, 100, 500, 500);
            
            //[cell addSubview:progress];
         
            [cell.progressBar setHidden:NO];
            [cell.downloadLabel setHidden:NO];
            //[cell.activity setHidden:NO];
           // [cell.activity startAnimating];
        }
        else if(indexOfFile != sender.tag)
        {
            [Utilities showAlertOKWithTitle:@"Download Alert!!" withMessage:@"Download in Progress!! Please try again"];
        }
        else
        {
            isDownloadInProgress = NO;
            [dataSource cancelDownload];
            [self.filelistView reloadData];
        }
    }
    
    
}


#pragma mark datasource delegates

-(void)dataSourceDidFetchList:(NSMutableArray *)fileListArray
{
    [self dismissHUD];
    dataArray = [fileListArray copy];
    
    NSLog(@"count is %d%d",[dataArray count],[fileListArray count]);
    
//    NSInteger height = [dataArray count] * 120;
//    
//    NSLog(@"height is %d",height);
//    
////    if(height <= 960)
////    {
////        [self.filelistView setFrame:CGRectMake(0, 215, 768, height)];
////    }
////    else
////    {
////        [self.filelistView setFrame:CGRectMake(0, 215, 768, 720)];
////    }
//
//    [self.filelistView setFrame:CGRectMake(0, 215, 768, height)];
    
    [self.filelistView reloadData];
    
}

-(void)dataSourceDidFailFetchingList:(NSError *)error
{
    
}

-(void)didDownloadFile
{
    isDownloadInProgress = NO;
    [self.filelistView reloadData];
    
    NSLog(@"file downloaded is %f",filedownload);
}
-(void)didFailDownloadFile
{
    isDownloadInProgress = NO;
    [self.filelistView reloadData];
}

-(void)updateProgress:(NSInteger)fileSizeDownloaded
{
    ListTableCell* cell = (ListTableCell*)[self.filelistView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexOfFile inSection:0]];
    
       //NSLog(@"file size is %d",fileSizeDownloaded);
    
    float ratio = (float)fileSizeDownloaded/(long long)([(file*)[dataArray objectAtIndex:indexOfFile] fileSize]);
    
   // filedownload = filedownload+fileSizeDownloaded;

    //NSLog(@"progress is %f",ratio);

    
    cell.progressBar.progress = ratio;
   // NSLog(@"progress is %f",cell.progressBar.progress);
    
  //  NSLog(@"file size is %lld ",[(file*)[dataArray objectAtIndex:indexOfFile] fileSize]);
}

@end
