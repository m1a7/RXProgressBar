//
//  RXMiddleViewModelCell.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseViewModelCell.h"
// Model
#import "RXMiddleCellModel.h"

@class RXProgressBar;

@interface RXMiddleViewModelCell : RXBaseViewModelCell

@property(strong, nonatomic) RXMiddleCellModel* model_cell;

@property(assign, nonatomic) float x_InstructionLabel;
@property(assign, nonatomic) float y_InstructionLabel;
@property(assign, nonatomic) float height_InstructionLabel;
@property(assign, nonatomic) float width_InstructionLabel;

@property(assign, nonatomic) float x_PhotoGallary;
@property(assign, nonatomic) float y_PhotoGallary;
@property(assign, nonatomic) float height_PhotoGallary;
@property(assign, nonatomic) float width_PhotoGallary;

// These properties need for optimized work with tableview
@property (nonatomic, strong) NSMutableArray<NSURLSessionDownloadTask*>* arrConnection;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic,  weak)  NSCache* imageCache;

-(instancetype) initWithModel:(id<RXInstructionModelProtocol>) model withProgressBar:(RXProgressBar*) pb;

@end
