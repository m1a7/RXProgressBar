//
//  RXEndCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"

// ViewModel Cell
#import "RXEndViewModelCell.h"

// UI Config
#import "RXUIConfig.h"

@interface RXEndCell : RXBaseCell

// ViewModel Cell
@property(weak, nonatomic) RXEndViewModelCell* vm_cell;

// UI property
@property(strong,nonatomic) UILabel* checkPoint;
@property(strong,nonatomic) UIView* verticalLine;

// Calculate height
 + (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config  withVM:(RXEndViewModelCell*) vm withSuperViewWidth:(CGFloat)width;

- (void) initVerticalLineAndCheckPoint:(RXEndViewModelCell*)vm;
- (void) setInNilAllComponent;


@end
