//
//  RXEndViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//
#import "RXBaseViewModelCell.h"

// Cell Model
#import "RXEndCellModel.h"

@class RXProgressBar;

@interface RXEndViewModelCell : RXBaseViewModelCell

@property (strong, nonatomic) RXEndCellModel* model_cell; // Model

-(instancetype) initWithModel:(id<RXBaseCellModelProtocol>) model
              withProgressBar:(RXProgressBar*) pb;

@end



