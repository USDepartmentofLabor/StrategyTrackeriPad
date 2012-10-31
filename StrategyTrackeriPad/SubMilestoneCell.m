//
//  SubMilestoneCell.m
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/25/12.
//  Copyright (c) 2012 U.S. Department of Labor. All rights reserved.
//

#import "SubMilestoneCell.h"

@implementation SubMilestoneCell

@synthesize dateDue, whenDue, milestoneText, milestoneID, milestoneStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SubMilestoneCell_iPad" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
