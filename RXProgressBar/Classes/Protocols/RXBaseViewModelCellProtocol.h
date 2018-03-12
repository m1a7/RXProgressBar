//
//  RXBaseViewModelCellProtocol.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

@class RXProgressBar;

typedef enum  RXStatusCell {
    RXStatusCellIsDone,
    RXStatusCellIsInProcess,
    RXStatusCellIsInWaiting
} RXStatusCell;


@protocol RXBaseViewModelCellProtocol <NSObject>

@property (weak,   nonatomic) RXProgressBar* progressBar;
@property (assign, nonatomic) RXStatusCell cellStatus;

 - (void)  deleteRow;
 - (void)  deleteAllRowsAtProgressBar;
 - (float) getTotalHeightWithOffset:(float) offset; 

- (BOOL) statusCellIsDone;
- (BOOL) statusCellInProcess;
- (BOOL) statusCellIsWaiting;

@end
