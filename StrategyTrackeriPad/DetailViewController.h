//
//  DetailViewController.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOVDataRequest.h"
#import "GOVDataContext.h"

@interface DetailViewController : UITableViewController <UISplitViewControllerDelegate, GOVDataRequestDelegate>
{
    NSArray *arrayOfMilestones;
    NSDictionary *dictionaryOfMilestones;
    
    GOVDataRequest *dataRequest;

}
@property (strong, nonatomic) id detailItem;

@property (nonatomic, retain) NSArray *arrayOfMilestones;
@property (nonatomic, retain) GOVDataRequest *dataRequest;
@property (nonatomic, retain) NSDictionary *dictionaryOfMilestones;

-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithDictionaryResults:(NSDictionary *)resultsDictionary;
-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithResults:(NSArray *)resultsArray;
-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithError:(NSString *)error;


@end

