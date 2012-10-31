//
//  DetailViewController.m
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Code available in the public domain
//

#import "DetailViewController.h"
#import "MilestoneCell.h"
#import "SubMilestoneCell.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
@synthesize dataRequest, arrayOfMilestones, dictionaryOfMilestones;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
    NSLog(@"URL = %@", _detailItem);
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        NSString *API_KEY = @"";
        NSString *API_SECRET = @"";
        NSString *API_HOST = [self.detailItem stringByReplacingOccurrencesOfString:@"/digitalstrategy.json" withString:@""];
        NSString *API_URL = @"";
        NSString *method = @"digitalstrategy.json";
        
        GOVDataContext *context = [[GOVDataContext alloc] initWithAPIKey:API_KEY Host:API_HOST SharedSecret:API_SECRET APIURL:API_URL];
        
        dataRequest = [[GOVDataRequest alloc] initWithContext:context];
        
        dataRequest.delegate = self;
        
        int timeOut = 20;
        
        NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys: nil];
        
        [dataRequest callAPIMethod:method withArguments:arguments andTimeOut:timeOut];
    
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Milestones", @"Milestones");
    }
    return self;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Agencies", @"Agencies");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
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
    return [self.arrayOfMilestones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *milestone = (NSDictionary *)[arrayOfMilestones objectAtIndex:indexPath.row];
    
    MilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   /* UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MilestoneCell_iPad" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[MilestoneCell class] ]) {
                cell = (MilestoneCell *)currentObject;
                break;
            }
        }*/
        /*   cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } */
//    }
    
    // Configure the cell...
    
    
    NSLog(@"%@", milestone);
    
        cell.dateDue.text = (NSString *)[milestone objectForKey:@"due_date"];
    cell.milestoneStatus.text = @"";
     //   cell.whenDue.text = (NSString *)[milestone objectForKey:@"due"];
    //cell.milestoneText.numberOfLines = 0;
    //cell.milestoneText.lineBreakMode = UILineBreakModeWordWrap;
    cell.milestoneID.text = (NSString *)[milestone objectForKey:@"id"];
    NSArray *milestoneFields = (NSArray *)[milestone objectForKey:@"fields"];
    NSDictionary *milestoneFieldZero = (NSDictionary *)[milestoneFields objectAtIndex:0];
    cell.milestoneText.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.milestoneText.dataDetectorTypes = UIDataDetectorTypeLink;
    cell.milestoneText.editable = NO;
    
    
    NSArray *basicMilestones = [[NSArray alloc] initWithObjects:@"2.1",@"7.1",@"5.2",@"8.2",@"1.2",@"2.2",@"5.3",@"6.3",@"7.2", nil];
    if ([basicMilestones containsObject:(NSString *)[milestone objectForKey:@"id"]]) {
        cell.milestoneText.text = (NSString *)[milestone objectForKey:@"text"];
        cell.milestoneStatus.text = (NSString *)[milestoneFieldZero objectForKey:@"value"];
    } else {
        if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"2.1.1"] || [(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"7.1.1"]) {
            // 2.1.1 or 7.1.1
            cell.milestoneText.text = (NSString *)[milestoneFieldZero objectForKey:@"value"];
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"4.2"]){
            // 4.2
            cell.milestoneStatus.text = (NSString *)[milestoneFieldZero objectForKey:@"value"];
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSString *fourPointTwoDetails = [[NSString alloc] initWithFormat:@"%@\r\r%@\r%@", [milestone objectForKey:@"text"],[milestoneFieldOne objectForKey:@"label"],[milestoneFieldOne objectForKey:@"value"]];
            cell.milestoneText.text = fourPointTwoDetails;
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"8.2.1"] || [(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"8.2.2"] || [(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"1.2.2"]) {
            // 8.2.1 or 8.2.2 or 1.2.2 or 2.2.1
            NSString *eightPointTwoOneDetails = [[NSString alloc] initWithFormat:@"%@\r\r%@:\r%@", [milestone objectForKey:@"text"],[milestoneFieldZero objectForKey:@"label"],[milestoneFieldZero objectForKey:@"value"]];
            cell.milestoneText.text = eightPointTwoOneDetails;
        }else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"5.2.1"]){
        //NSLog(@"======");
        //NSLog(@"%@", milestoneFieldZero);
        //NSLog(@"======");
           //cell.milestoneStatus.text = (NSString *)[milestoneFieldZero objectForKey:@"value"];
//            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSString *fourPointTwoDetails = [[NSString alloc] initWithFormat:@"%@\r\r%@\r%@", [milestone objectForKey:@"text"],[milestoneFieldZero objectForKey:@"label"],[milestoneFieldZero objectForKey:@"value"]];
            cell.milestoneText.text = fourPointTwoDetails;
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"5.2.2"]){
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSDictionary *milestoneFieldTwo = (NSDictionary *)[milestoneFields objectAtIndex:2];
            //            NSLog(@"======");
            //            NSLog(@"%@", milestoneFieldOne);
            //            NSLog(@"======");
            NSArray *serviceInventoryStatus = (NSArray *)[milestoneFieldTwo objectForKey:@"value"];
            NSArray *deviceInventoryStatus = (NSArray *)[milestoneFieldOne objectForKey:@"value"];
            NSString *listOfDeliverables = [[[NSString alloc] initWithFormat:@"%@: %@\r%@: %@", [milestoneFieldOne objectForKey:@"label"],[deviceInventoryStatus objectAtIndex:0],[milestoneFieldTwo objectForKey:@"label"],[serviceInventoryStatus objectAtIndex:0]] autorelease];
            cell.milestoneText.text = listOfDeliverables;
            
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"1.2.1"]){
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            //            NSLog(@"======");
            //            NSLog(@"%@", milestoneFieldOne);
            //            NSLog(@"======");
//            NSArray *deviceInventoryStatus = (NSArray *)[milestoneFieldZero objectForKey:@"value"];
//            NSArray *serviceInventoryStatus = (NSArray *)[milestoneFieldOne objectForKey:@"value"];
            NSString *listOfDeliverables = [[[NSString alloc] initWithFormat:@"%@\r\r%@: %@\r%@: %@", [milestone objectForKey:@"text"],[milestoneFieldZero objectForKey:@"label"],[milestoneFieldZero objectForKey:@"value"],[milestoneFieldOne objectForKey:@"label"],[milestoneFieldOne objectForKey:@"value"]] autorelease];
            cell.milestoneText.text = listOfDeliverables;
            
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"4.2.3"]){
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSArray *fourPointTwoThreeStatus = (NSArray *)[milestoneFieldOne objectForKey:@"value"];
            cell.milestoneStatus.text = (NSString *)[fourPointTwoThreeStatus objectAtIndex:0];
            NSString *fourPointTwoThreeDetails = [[NSString alloc] initWithFormat:@"%@\r\r%@\r%@", [milestone objectForKey:@"text"],[milestoneFieldZero objectForKey:@"label"],[milestoneFieldZero objectForKey:@"value"]];
            cell.milestoneText.text = fourPointTwoThreeDetails;
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"2.1.2"] || [(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"7.1.2"]) {
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSArray *milestoneFieldOneArray = (NSArray *) [milestoneFieldOne objectForKey:@"value"];
          //  NSLog(@"======");
          //  NSLog(@"%@", milestoneFieldOne);
          //  NSLog(@"======");
            NSMutableString *listOfDeliverables = [[[NSMutableString alloc] init] autorelease];
            [listOfDeliverables appendString:(NSString *)[milestoneFieldOneArray objectAtIndex:0]];
            [listOfDeliverables appendString:@"\r"];
            NSArray *deliverableArray = (NSArray *)[milestoneFieldZero objectForKey:@"value"];
            for (int i=0; i < [deliverableArray count]; i++) {
                [listOfDeliverables appendString:@"\r"];
                [listOfDeliverables appendString:(NSString *)[deliverableArray objectAtIndex:i]];
            }
            cell.milestoneText.text = listOfDeliverables;
//            cell.milestoneText.text = (NSString *)[milestoneFieldOneArray objectAtIndex:0];
/*            cell.deliverableList.numberOfLines = 0;
            cell.deliverableList.lineBreakMode = UILineBreakModeWordWrap;
            cell.deliverableList.font = [UIFont fontWithName:@"Helvetica" size:8];
            cell.deliverableList.text = listOfDeliverables;*/
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"4.2.1"]){
            NSMutableString *goalDetails = [[[NSMutableString alloc] init] autorelease];
            [goalDetails appendString:@"Goals"];
            NSArray *milestoneGoalsArray = (NSArray *)[milestone objectForKey:@"fields"];
            for (int i=0; i < [milestoneGoalsArray count]; i++) {
                NSDictionary *goalItem = (NSDictionary *)[milestoneGoalsArray objectAtIndex:i];
                [goalDetails appendFormat:@"\r%@: %@", [goalItem objectForKey:@"label"],[goalItem objectForKey:@"value"]];
            }
            cell.milestoneText.text = goalDetails;
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"2.2.1"]) {
            NSMutableString *listOfDeliverables = [[[NSMutableString alloc] init] autorelease];
            [listOfDeliverables appendFormat:@"%@\r\r%@", [milestone objectForKey:@"text"],[milestoneFieldZero objectForKey:@"label"]];
            NSArray *deliverableArray = (NSArray *)[milestoneFieldZero objectForKey:@"value"];
            for (int i=0; i < [deliverableArray count]; i++) {
                if (i > 0) {
                    [listOfDeliverables appendString:@"\r"];
                }
                [listOfDeliverables appendString:(NSString *)[deliverableArray objectAtIndex:i]];
            }
            cell.milestoneText.text = listOfDeliverables;
        } else if ([(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"2.2.2"] || [(NSString *)[milestone objectForKey:@"id"] isEqualToString:@"7.2.1"]){
            NSDictionary *milestoneFieldOne = (NSDictionary *)[milestoneFields objectAtIndex:1];
            NSDictionary *milestoneFieldTwo = (NSDictionary *)[milestoneFields objectAtIndex:2];
            NSDictionary *milestoneFieldThree = (NSDictionary *)[milestoneFields objectAtIndex:3];
            NSDictionary *milestoneFieldFour = (NSDictionary *)[milestoneFields objectAtIndex:4];
            NSDictionary *milestoneFieldFive = (NSDictionary *)[milestoneFields objectAtIndex:5];
            NSMutableString *listOfDeliverables = [[[NSMutableString alloc] init] autorelease];
            [listOfDeliverables appendFormat:@"%@:\r%@: %@\r%@: %@\r%@: %@\r%@: %@\r%@: %@\r%@: %@\r", [milestone objectForKey:@"text"],
             [milestoneFieldZero objectForKey:@"label"],
             [milestoneFieldZero objectForKey:@"value"],
             [milestoneFieldOne objectForKey:@"label"],
             [milestoneFieldOne objectForKey:@"value"],
             [milestoneFieldTwo objectForKey:@"label"],
             [milestoneFieldTwo objectForKey:@"value"],
             [milestoneFieldThree objectForKey:@"label"],
             [milestoneFieldThree objectForKey:@"value"],
             [milestoneFieldFour objectForKey:@"label"],
             [milestoneFieldFour objectForKey:@"value"],
             [milestoneFieldFive objectForKey:@"label"],
             [milestoneFieldFive objectForKey:@"value"]
             ];
            cell.milestoneText.text = listOfDeliverables;
        }
        //cell.milestoneText.text = (NSString *)[milestoneFieldZero objectForKey:@"value"];
        

    }
//    cell.textLabel.text = (NSString *)[milestone objectForKey:@"due"];
//    cell.detailTextLabel.text = (NSString *)[milestone objectForKey:@"text"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 240;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

# pragma mark - GovDataSDK

-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithDictionaryResults:(NSDictionary *)resultsDictionary {
    //    NSLog(@"Got a Dictionary");
   // self.arrayOfMilestones = [[[resultsDictionary objectForKey:@"items"] objectForKey:@"items" ] retain];
    self.arrayOfMilestones = [[resultsDictionary objectForKey:@"items"] retain];
    //NSLog(@"%@", strategyItemsList);
    //NSLog(@"Item count: %d", [strategyItemsList count]);
   //     NSLog(@"%@", arrayOfMilestones);
    [self.tableView reloadData];
    
}

-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithResults:(NSArray *)resultsArray {
    NSLog(@"Got an array back");
    
    self.arrayOfMilestones = [resultsArray retain];
    
    [self.tableView reloadData];
}

-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithError:(NSString *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

@end
