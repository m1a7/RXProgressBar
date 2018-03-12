//
//  RXBeginCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"

@class RXBeginViewModelCell;
@class RXUIConfig;

@interface RXBeginCell : RXBaseCell

//  Cell's ViewModel
@property(weak, nonatomic) RXBeginViewModelCell* vm_cell;

// Calculate height
+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config
                               withVM:(id<RXBaseViewModelCellProtocol>) vm
                   withSuperViewWidth:(CGFloat)width;

@end
