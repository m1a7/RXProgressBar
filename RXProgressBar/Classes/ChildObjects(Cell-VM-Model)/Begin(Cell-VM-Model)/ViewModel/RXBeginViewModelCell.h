//
//  RXBeginViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseViewModelCell.h"
// Cell Model
#import "RXBeginCellModel.h"

@class RXProgressBar;


@interface RXBeginViewModelCell : RXBaseViewModelCell

@property (strong, nonatomic) RXBeginCellModel* model_cell; // Model

-(instancetype) initWithModel:(id<RXBaseCellModelProtocol>) model withProgressBar:(RXProgressBar*) pb;

/*
 Get total height of cell with all offset between uicomponents
*/
-(float) getTotalHeightWithOffset:(float) offset;

@end

