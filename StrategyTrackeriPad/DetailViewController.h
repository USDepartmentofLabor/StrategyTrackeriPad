//
//  DetailViewController.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
