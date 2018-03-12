//
//  RXEndCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"

// Cell's ViewModel
@class RXEndViewModelCell;
// UI Config
@class RXUIConfig;


@interface RXEndCell : RXBaseCell

@property(weak, nonatomic) RXEndViewModelCell* vm_cell; // Cell's ViewModel

// Calculate height
+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config
                               withVM:(id<RXBaseViewModelCellProtocol>) vm
                   withSuperViewWidth:(CGFloat)width;
@end
