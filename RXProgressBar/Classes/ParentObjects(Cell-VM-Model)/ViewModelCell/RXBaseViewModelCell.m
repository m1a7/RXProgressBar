//
//  RXBaseViewModelCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseViewModelCell.h"


@implementation RXBaseViewModelCell

#pragma mark - RXBaseViewModelCellProtocol

- (void) deleteRow {
    [self.progressBar deleteRow: self];
}

- (void) deleteAllRowsAtProgressBar {
    [self.progressBar deleteProgressBar];
}

- (float) getTotalHeightWithOffset:(float) offset {
    return 0.f;
}

- (BOOL) statusCellIsDone{
    return self.cellStatus == RXStatusCellIsDone;
}

- (BOOL) statusCellInProcess{
    return self.cellStatus == RXStatusCellIsInProcess;
}

- (BOOL) statusCellIsWaiting{
    return self.cellStatus == RXStatusCellIsInWaiting;
}

@end
