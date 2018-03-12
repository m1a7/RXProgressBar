//
//  RXBaseCellProtocl.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

#import "RXBaseViewModelCellProtocol.h"
#import "RXUIConfig.h"

@class RXCheckPoint;
@class RXBeforeLine;
@class RXAfterLine;

@protocol RXBaseCellProtocol <NSObject>

@property(strong,nonatomic) RXCheckPoint* checkPoint;
@property(strong,nonatomic) RXBeforeLine* lineBeforePoint;
@property(strong,nonatomic) RXAfterLine*  lineAfterPoint;


- (void) initVerticalLineAndCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index;

+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config withVM:(id<RXBaseViewModelCellProtocol>) vm  withSuperViewWidth:(CGFloat)width;


@end
