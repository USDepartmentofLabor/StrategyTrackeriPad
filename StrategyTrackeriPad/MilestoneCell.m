//
//  MilestoneCell.m
//  StrategyTrackeriPad
//
//  Created by Michael Pulsifer on 10/24/12.
//  Code available in the public domain
//

#import "MilestoneCell.h"

@implementation MilestoneCell

@synthesize dateDue, whenDue, milestoneText, milestoneID, milestoneStatus, deliverableList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MilestoneCell_iPhone" owner:self options:nil];
            self = [nibArray objectAtIndex:0];
        } else {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MilestoneCell_iPad" owner:self options:nil];
            self = [nibArray objectAtIndex:0];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
