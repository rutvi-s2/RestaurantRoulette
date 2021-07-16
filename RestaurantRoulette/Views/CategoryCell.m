//
//  CategoryCell.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/15/21.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)checkboxPressed:(id)sender {
    if([[self.checkboxButton currentBackgroundImage] isEqual: [UIImage imageNamed:@"checkbox_checked"]]){
        [self.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
    }else{
        [self.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
