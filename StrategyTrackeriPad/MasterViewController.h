//
//  MasterViewController.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Code available in the public domain
//

#import <UIKit/UIKit.h>
#import "GOVDataRequest.h"
#import "GOVDataContext.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <GOVDataRequestDelegate> {

NSArray *arrayOfAgencies;
NSDictionary *dictionaryOfAgencies;

GOVDataRequest *dataRequest;
}

@property (nonatomic, retain) NSArray *arrayOfAgencies;
@property (nonatomic, retain) GOVDataRequest *dataRequest;
@property (nonatomic, retain) NSDictionary *dictionaryOfAgencies;


@property (strong, nonatomic) DetailViewController *detailViewController;

-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithDictionaryResults:(NSDictionary *)resultsDictionary;
-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithResults:(NSArray *)resultsArray;
-(void)govDataRequest:(GOVDataRequest *)request didCompleteWithError:(NSString *)error;

@end
