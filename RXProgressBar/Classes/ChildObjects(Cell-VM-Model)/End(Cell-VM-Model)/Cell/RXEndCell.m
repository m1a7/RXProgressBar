//
//  RXEndCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXEndCell.h"

#import "RXEndViewModelCell.h"
#import "RXUIConfig.h"

#import "RXBeforeLine.h"
#import "RXAfterLine.h"

@implementation RXEndCell

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

- (void) resizeSubviews{
    if (self.checkPoint){
        self.checkPoint.frame  = [RXBaseCell cgrectEndCellCheckPoint:self.vm_cell
                                             andFrameSuperView:self.contentView.frame];
    }
    if (self.lineBeforePoint){
        self.lineBeforePoint.frame = [self cgrectEndCellLineBefore:self.vm_cell
                                                 andFrameSuperView:self.contentView.frame];
    }
}
#pragma mark - UI methods

- (void) initUIComponentsWithVM:(RXEndViewModelCell*)vm
{
    // Here is the UI setup
     self.contentView.backgroundColor = vm.progressBar.configUI.backgroundColorForCell;
    // Draw the arrow
    [self initVerticalLineAndCheckPoint:vm andFrameSuperView:self.contentView.frame andIndexInArray:0];
    [self setupColors:vm andFrameSuperView:self.contentView.frame andIndexInArray:0];
}

- (void) setInNilAllComponent
{
    for (UIView* subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.checkPoint      = nil;
    self.lineBeforePoint = nil;
    self.lineAfterPoint  = nil;
}

#pragma mark -  Setter for ViewModel

- (void) setVm_cell:(RXEndViewModelCell *)vm_cell{
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
 
    RXEndViewModelCell* convertVM;
    if ([vm isKindOfClass:[RXEndViewModelCell class]]){
        convertVM = (RXEndViewModelCell*)vm;
    }
    if (convertVM.height_CheckPoint <= 0 || convertVM.actualCalculationsForWidth != width)
    {
        convertVM.height_CheckPoint  = [RXBaseCell cgrectEndCellCheckPoint:vm andFrameSuperView:CGRectMake(0, 0, width, 0)].size.height;
    }
    return [convertVM getTotalHeightWithOffset: convertVM.progressBar.configUI.standartOffSetBetweenUIComponents];
}
@end














