//
//  MasterViewController.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
