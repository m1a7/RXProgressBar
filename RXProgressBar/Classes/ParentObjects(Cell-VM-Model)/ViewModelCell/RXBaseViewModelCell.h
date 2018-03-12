//
//  RXBaseViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

#import "RXBaseViewModelCellProtocol.h"
#import "RXProgressBar.h"

@interface RXBaseViewModelCell : NSObject <RXBaseViewModelCellProtocol>

#pragma mark - RXBaseViewModelCellProtocol

@property (weak,   nonatomic)  RXProgressBar* progressBar;
@property (assign, nonatomic)  RXStatusCell   cellStatus;
@property (assign, nonatomic)  float actualCalculationsForWidth;
@property (assign, nonatomic)  float actualCalculationsForHeight;

@property (assign, nonatomic)  float height_CheckPoint;

- (void) deleteRow;
- (void) deleteAllRowsAtProgressBar;
- (float) getTotalHeightWithOffset:(float) offset;

- (BOOL) statusCellIsDone;
- (BOOL) statusCellInProcess;
- (BOOL) statusCellIsWaiting;

@end

