//
//  RXBeginCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBeginCell.h"

// ViewModel Cell
#import "RXBeginViewModelCell.h"

// From this class get UI Style for our cell
#import "RXUIConfig.h"


// These classes "before" uiview line  and "after" uiview line
#import "RXBeforeLine.h"
#import "RXAfterLine.h"

@implementation RXBeginCell

#pragma mark - Standart UITableViewCell methods

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

#pragma mark - Layout/Resize subview

-(void) layoutSubviews{
    [super layoutSubviews];
    [self  resizeSubviews];
}

- (void) resizeSubviews
{
    if (self.checkPoint){
        self.checkPoint.frame    = [RXBaseCell cgrectBeginCellCheckPoint:self.vm_cell andFrameSuperView:self.contentView.frame];
    }
    if (self.lineAfterPoint){
        self.lineAfterPoint.frame = [self cgrectBeginCellLineAfter:self.vm_cell andFrameSuperView:self.contentView.frame];
    }
}

#pragma mark - UI methods

- (void) initUIComponentsWithVM:(RXBeginViewModelCell*)vm
{
    // Here is the UI setup
    self.contentView.backgroundColor = vm.progressBar.configUI.backgroundColorForCell;
    // Draw the arrow
    [self initVerticalLineAndCheckPoint:vm andFrameSuperView:self.contentView.frame andIndexInArray:0]; 
}

- (void) setInNilAllComponent
{
    for (UIView* subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.checkPoint = nil;
    self.lineBeforePoint = nil;
    self.lineAfterPoint  = nil;
}

#pragma mark -  Setter for ViewModel

- (void) setVm_cell:(RXBeginViewModelCell *)vm_cell{
    _vm_cell = vm_cell;
    [self setDataToCell];
}

- (void) setDataToCell {
    [self setInNilAllComponent];
    [self initUIComponentsWithVM:self.vm_cell];
}


#pragma mark - Calculate height of Cell

+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config withVM:(id<RXBaseViewModelCellProtocol>) vm  withSuperViewWidth:(CGFloat)width
{
    RXBeginViewModelCell* convertVM;
    if ([vm isKindOfClass:[RXBeginViewModelCell class]]){
        convertVM = (RXBeginViewModelCell*)vm;
    }
    if (convertVM.height_CheckPoint <= 0 || convertVM.actualCalculationsForWidth != width)
    {
        convertVM.height_CheckPoint  = [RXBaseCell cgrectBeginCellCheckPoint:vm andFrameSuperView:CGRectMake(0, 0, width, 0)].size.height;
    }
    return [convertVM getTotalHeightWithOffset: convertVM.progressBar.configUI.standartOffSetBetweenUIComponents];
}


@end
