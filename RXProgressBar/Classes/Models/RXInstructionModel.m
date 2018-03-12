//
//  RXInstructionModel.m
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import "RXInstructionModel.h"

@implementation RXInstructionModel

- (instancetype)initWithInstruction:(NSString*) instruction withImgsURL:(NSArray<id<RXInstructionImgModelProtocol>>*)imgArr
{
    self = [super init];
    if (self) {
        self.instruction = instruction;
        self.imagesURL   = [NSArray arrayWithArray:imgArr];
    }
    return self;
}

- (instancetype)initWithInstruction:(NSString*) instruction withMixArrImgs:(NSArray*)imgArr
{
    self = [super init];
    if (self) {
        self.instruction = instruction;
        self.imagesURL   = [NSArray arrayWithArray:imgArr];
    }
    return self;
}


@end
