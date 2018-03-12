//
//  RXMiddleViewModelCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXMiddleViewModelCell.h"

#import "RXProgressBar.h"

@implementation RXMiddleViewModelCell

- (instancetype)initWithModel:(id<RXInstructionModelProtocol>) model  withProgressBar:(RXProgressBar*) pb
{
    self = [super init];
    if (self) {
        
        self.model_cell = [[RXMiddleCellModel alloc] init];
        if (model){
            self.model_cell.instruction = model.instruction;
            self.model_cell.imagesURL   = model.imagesURL;
        }
        
        self.progressBar = pb;
        
        self.imageOperationQueue = [NSOperationQueue mainQueue];
        self.imageOperationQueue.maxConcurrentOperationCount = 5;
        self.arrConnection = [NSMutableArray new];
    }
    return self;
}

- (float) getTotalHeightWithOffset:(float) offset
{
    float totalHeight = 0;
    totalHeight += offset;
    
    if (self.height_InstructionLabel > 0){
        totalHeight += self.height_InstructionLabel;
        totalHeight += offset;
    }
    if (self.model_cell.imagesURL.count>0){
        totalHeight += self.height_PhotoGallary;
        totalHeight += offset;
    }
    
    return MAX(roundf([self totalHeighOfVerticalLine:offset]),  roundf(totalHeight));
}

- (float) totalHeighOfVerticalLine:(float) offset {
    
    NSAssert(offset>=0, @"OffSet в totalHeighOfVerticalLine equal to zero! (Error in calculating the height of the cell)");
    NSAssert(self.height_CheckPoint >= 0, @"self.height_CheckPoint  в totalHeighOfVerticalLine  equal to zero");
    return offset + self.height_CheckPoint + offset;
}


@end
