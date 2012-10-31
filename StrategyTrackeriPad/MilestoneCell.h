//
//  MilestoneCell.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MilestoneCell : UITableViewCell {
    
    IBOutlet UILabel *whenDue;
    IBOutlet UITextView *milestoneText;
    IBOutlet UILabel *dateDue;
    IBOutlet UILabel *milestoneStatus;
    IBOutlet UILabel *milestoneID;
    IBOutlet UILabel *deliverableList;
    
    IBOutlet UIView *viewForBackground;
}

@property (nonatomic, retain) IBOutlet UILabel *whenDue;
@property (nonatomic, retain) IBOutlet UITextView *milestoneText;
@property (nonatomic, retain) IBOutlet UILabel *dateDue;
@property (nonatomic, retain) IBOutlet UILabel *milestoneStatus;
@property (nonatomic, retain) IBOutlet UILabel *milestoneID;
@property (nonatomic, retain) IBOutlet UILabel *deliverableList;

@end
