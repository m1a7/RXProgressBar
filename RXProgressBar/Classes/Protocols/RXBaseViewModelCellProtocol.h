//
//  RXBaseViewModelCellProtocol.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

@protocol RXBaseViewModelCellProtocol <NSObject>

//@property (weak, nonatomic) RXProgressBar* progressBar;

 - (void) deleteRow;
 - (void) deleteAllRowsAtProgressBar;
 - (float) getTotalHeightWithOffset:(float) offset; 

@end
