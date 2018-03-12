//
//  RXMiddleCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"
#import <RXLayoutGallary/RXLayoutGallary.h>

// ViewModel
#import "RXMiddleViewModelCell.h"

// Model for NYTPhotoViewController
#import <NYTPhotoViewer/NYTPhotosViewController.h>


@interface RXMiddleCell : RXBaseCell <RXLayoutGallaryDelegate>

// ViewModel
@property(weak, nonatomic) RXMiddleViewModelCell* vm_cell;

// UI property
@property(strong, nonatomic) UILabel         *instructionLabel;
@property(strong, nonatomic) RXLayoutGallary *photoGallary;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat) calculateHeightByUIConfig:(NSObject*) conf withVM:(RXMiddleViewModelCell*) vm withWidthView:(CGFloat)width;



@end
