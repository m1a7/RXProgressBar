//
//  RXBeginCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"

// ViewModel Cell
#import "RXBeginViewModelCell.h"

#import "RXUIConfig.h"

@interface RXBeginCell : RXBaseCell

// ViewModel Cell
@property(weak, nonatomic) RXBeginViewModelCell* vm_cell;

// UI Properties
@property(strong,nonatomic) UILabel* checkPoint;
@property(strong,nonatomic) UIView* verticalLine;

// Calculate height
+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config withVM:(RXBeginViewModelCell*) vm  withSuperViewWidth:(CGFloat)width;


- (void) initVerticalLineAndCheckPoint:(RXBeginViewModelCell*)vm;
- (void) setInNilAllComponent;



@end
