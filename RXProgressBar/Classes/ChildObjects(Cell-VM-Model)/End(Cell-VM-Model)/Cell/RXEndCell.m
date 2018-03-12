//
//  RXEndCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXEndCell.h"

@implementation RXEndCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config  withVM:(RXEndViewModelCell*) vm withSuperViewWidth:(CGFloat)width;
 {
 return (config.customEndCellHeight) ?  config.customEndCellHeight : config.standartEndCellHeight;
 }
 
 
 - (void) initVerticalLineAndCheckPoint:(RXEndViewModelCell*)vm
 {
     self.checkPoint  = [[UILabel alloc] init];
     self.verticalLine = [UIView new];
     
     [self.contentView addSubview: self.checkPoint];
     [self.contentView addSubview: self.verticalLine];
 }
 
 - (void) setInNilAllComponent
 {
    for (UIView* subView in self.contentView.subviews) {
         [subView removeFromSuperview];
        }
   self.checkPoint = nil;
   self.verticalLine = nil;
 }
 
 -(void) layoutSubviews{
         [super layoutSubviews];
         [self  resizeSubviews];
 }


 - (void) resizeSubviews
 {
 
 }


@end
