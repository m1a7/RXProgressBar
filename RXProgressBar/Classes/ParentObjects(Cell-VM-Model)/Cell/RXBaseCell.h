//
//  RXBaseCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <UIKit/UIKit.h>

// Protocol - BaseCell
#import "RXBaseCellProtocol.h"
// Protocol - ViewModel BaseCell
#import "RXBaseViewModelCellProtocol.h"

// ViewModel - ViewModel BaseCell
#import "RXBaseViewModelCell.h"

// Custom label
#import "RXCheckPoint.h"


@class RXBeforeLine;
@class RXAfterLine;

// UI Config (it store all rows ui configurate style)
#import "RXUIConfig.h"

@interface RXBaseCell : UITableViewCell <RXBaseCellProtocol>

#pragma mark - UI properties
@property(strong,nonatomic) RXCheckPoint* checkPoint;
@property(strong,nonatomic) RXBeforeLine* lineBeforePoint;
@property(strong,nonatomic) RXAfterLine* lineAfterPoint;

#pragma mark - Init and Add on SuperView (checkPoint|lineBeforePoint|lineAfterPoint)

- (void) initVerticalLineAndCheckPoint:(id<RXBaseViewModelCellProtocol>)vm
                     andFrameSuperView:(CGRect)frame
                       andIndexInArray:(NSInteger) index;

#pragma mark - Route methods which direct RXBaseCell on some set style method

- (void) setupColors:(id<RXBaseViewModelCellProtocol>)vm
   andFrameSuperView:(CGRect)frame
     andIndexInArray:(NSInteger) index;


#pragma mark - Calculate height of Cell

+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config
                               withVM:(id<RXBaseViewModelCellProtocol>) vm
                   withSuperViewWidth:(CGFloat)width;


#pragma mark - Animate cell with in depending Cell Status

- (void) makeThisCellIsDoneStatus:(id<RXBaseViewModelCellProtocol>)vm
                andFrameSuperView:(CGRect)frame
                  andIndexInArray:(NSInteger) index;

- (void) makeNextCellIsInProcessingStatus:(id<RXBaseViewModelCellProtocol>)vm
                        andFrameSuperView:(CGRect)frame
                          andIndexInArray:(NSInteger) index;

- (void) makeSelfStatusInProccess:(id<RXBaseViewModelCellProtocol>)vm
                andFrameSuperView:(CGRect)frame
                  andIndexInArray:(NSInteger) index;


#pragma mark - Methods Get CGRect frame for (checkPoint|lineBeforePoint|lineAfterPoint)

#pragma - CGRect for RXBeginCell

// CGRect for RXBeginCell - CheckPoint
+ (CGRect)cgrectBeginCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;

// CGRect for RXBeginCell - LineAfter
- (CGRect)cgrectBeginCellLineAfter:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;


#pragma - CGRect for RXEndCell

// CGRect for RXEndCell - CheckPoint
+ (CGRect)cgrectEndCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;
// CGRect for RXEndCell - BeforeLine
- (CGRect)cgrectEndCellLineBefore:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;

#pragma - CGRect for RXMiddleCell

// CGRect for RXMiddleCell - CheckPoint
+ (CGRect)cgrectMiddleCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;

// CGRect for RXMiddleCell - BeforeLine
- (CGRect)cgrectMiddleCellBeforeLine:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;

// CGRect for RXMiddleCell - AfterLine
- (CGRect)cgrectMiddleCellAfterLine:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame;



@end
