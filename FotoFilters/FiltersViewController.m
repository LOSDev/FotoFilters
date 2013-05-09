//
//  FiltersViewController.m
//  CoreImageFun
//
//  Created by Rincewind on 03.05.13.
//  Copyright (c) 2013 Rincewind. All rights reserved.
//

#import "FiltersViewController.h"
#import "Filters.h"

@interface FiltersViewController ()
@property CIImage *ciImage;
@property CIContext *context;
@end

@implementation FiltersViewController

@synthesize properties=_properties;
@synthesize delegate;
@synthesize popoverController;
@synthesize image=_image;
@synthesize ciImage=_ciImage;
@synthesize context;
@synthesize previews=_previews;
@synthesize tView;
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    
    //get an Array of all Filters from the Filters class
    self.context = [CIContext contextWithOptions:nil];
    self.properties = [Filters getAllFilters];
    self.ciImage = [CIImage imageWithCGImage:self.image.CGImage];
  
   
    self.previews = [NSMutableDictionary dictionary];
    for (NSString *effect in self.properties) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            CIImage *outputImage = [Filters changeImage:self.ciImage withFilter:effect];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CGImageRef cgimg = [self.context createCGImage:outputImage fromRect:[self.ciImage extent]];
                UIImage *newImage = [UIImage imageWithCGImage:cgimg];
                
                [self.previews setObject:newImage forKey:effect];
                
                [self.tView reloadData];
                CGImageRelease(cgimg);
                
            });
        });
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.properties count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    //Set the Cell text from the properties-Aray loaded in viewDidLoad
    NSString *cellText = self.properties[indexPath.row];
    cell.textLabel.text= cellText;
    if (![self.previews objectForKey:cellText]) {
        
    }else{
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(0,0,THUMBNAIL_SIZE,THUMBNAIL_SIZE)];
        myImageView.tag = 1;
        myImageView.contentMode=UIViewContentModeScaleAspectFit;
        myImageView.image = [self.previews objectForKey:cellText];
        [cell addSubview:myImageView];
        //cell.imageView.image = [self.previews objectForKey:cellText];
    }
    
   
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return THUMBNAIL_SIZE;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calling the Delegate Method and dismissing the View Controller
    [self.delegate userDidMakeChoice:self.properties[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //For the iPad: Dismissing the Popover View Controller
    [self.popoverController dismissPopoverAnimated:YES];
    
}


//dismiss the View Controller when the Cancel Button is pressed (not on the iPad)
- (IBAction)goBack:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
