//
//  SubMilestoneCell.h
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/25/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubMilestoneCell : UITableViewCell {

    IBOutlet UILabel *whenDue;
    IBOutlet UILabel *milestoneText;
    IBOutlet UILabel *dateDue;
    IBOutlet UILabel *milestoneStatus;
    IBOutlet UILabel *milestoneID;

    IBOutlet UIView *viewForBackground;
}

@property (nonatomic, retain) IBOutlet UILabel *whenDue;
@property (nonatomic, retain) IBOutlet UILabel *milestoneText;
@property (nonatomic, retain) IBOutlet UILabel *dateDue;
@property (nonatomic, retain) IBOutlet UILabel *milestoneStatus;
@property (nonatomic, retain) IBOutlet UILabel *milestoneID;

@end
