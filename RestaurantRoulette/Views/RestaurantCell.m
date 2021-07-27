//
//  RestaurantCell.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)checkboxButton:(id)sender {
    if([[self.checkboxButton currentBackgroundImage] isEqual: [UIImage imageNamed:@"checkbox_checked"]]){
        [self.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
        self.business.visited = false;
    }else{
        [self.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        self.business.visited = true;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
