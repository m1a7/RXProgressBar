//
//  RXMiddleViewModelCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXMiddleViewModelCell.h"

#import "RXProgressBar.h"

@implementation RXMiddleViewModelCell

- (void) deleteRow {
    [self.progressBar deleteRow: self];
}

- (void) deleteAllRowsAtProgressBar {
    [self.progressBar deleteProgressBar];
}

- (float) getTotalHeightWithOffset:(float) offset {
    return 1.f;
}


- (instancetype)initWithModel:(id< RXInstructionModelProtocol>) model  withProgressBar:(RXProgressBar*) pb
{
    self = [super init];
    if (self) {
        //self.model = [[RXMiddleCellModel alloc] init];
        //self.model.instruction = model.instruction;
        //self.model.imagesURL = [NSArray arrayWithArray:model.imagesURL];
        self.model_cell = model;
        self.progressBar = pb;
        
        self.imageOperationQueue = [[NSOperationQueue alloc]init];
        self.imageOperationQueue.maxConcurrentOperationCount = 5;
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (float) getTotalHeightWithOffsets:(float) offset
{
    //float offset  = 20.f;
    float totalHeight = 0;
    totalHeight += offset;
    
    if (self.height_InstructionLabel > 0)
    {
        totalHeight += self.height_InstructionLabel;
        totalHeight += offset;
    }
    if (self.model_cell.imagesURL.count>0){
        totalHeight += self.height_PhotoGallary;
        totalHeight += offset;
    }
    return roundf(totalHeight);
}
@end
