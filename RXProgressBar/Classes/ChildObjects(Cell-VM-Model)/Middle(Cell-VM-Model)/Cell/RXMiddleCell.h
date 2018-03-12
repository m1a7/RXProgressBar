//
//  RXMiddleCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"
// Cell's ViewModel
#import "RXMiddleViewModelCell.h"

// Thrid-Party Fraemwork
#import <RXLayoutGallary/RXLayoutGallary.h>

@interface RXMiddleCell : RXBaseCell <RXLayoutGallaryDelegate>

@property(weak, nonatomic) RXMiddleViewModelCell* vm_cell; // Cell's ViewModel

// UI properties
@property(strong, nonatomic) UILabel         *instructionLabel;
@property(strong, nonatomic) RXLayoutGallary *photoGallary;


// Init method
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

// Calculate height of cell
+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config
                               withVM:(id<RXBaseViewModelCellProtocol>) vm
                   withSuperViewWidth:(CGFloat)width;

// Cancel all nsoperation
- (void) cancelAllRequest;


@end
