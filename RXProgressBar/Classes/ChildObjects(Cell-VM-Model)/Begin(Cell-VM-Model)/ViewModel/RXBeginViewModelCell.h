//
//  RXBeginViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseViewModelCell.h"
// Cell Model
#import "RXBeginCellModel.h"
// Protocol
#import "RXInstructionModelProtocol.h"

@class RXProgressBar;
@interface RXBeginViewModelCell : RXBaseViewModelCell

@property (weak, nonatomic)RXProgressBar* progressBar;

 - (void) deleteRow;
 - (void) deleteAllRowsAtProgressBar;
 - (float)getTotalHeightWithOffset:(float) offset;

// Model
@property (strong, nonatomic) RXBeginCellModel* model_cell;

-(instancetype) initWithModel:(id<RXInstructionModelProtocol>) model withProgressBar:(RXProgressBar*) pb;

@end

