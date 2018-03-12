//
//  RXEndViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

//#import <RXProgressBar/RXProgressBar.h>

#import "RXBaseViewModelCell.h"
// Model
#import "RXEndCellModel.h"
// Protocols
#import "RXInstructionModelProtocol.h"

@class RXProgressBar;

@interface RXEndViewModelCell : RXBaseViewModelCell

@property (weak, nonatomic)RXProgressBar* progressBar;


- (void) deleteRow;
- (void) deleteAllRowsAtProgressBar;
- (float)getTotalHeightWithOffset:(float) offset;

-(instancetype) initWithModel:(id<RXInstructionModelProtocol>) model withProgressBar:(RXProgressBar*) pb;

// Model
@property (strong, nonatomic) RXEndCellModel* model_cell;


@end



