//
//  RXInstructionImgModel.m
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import "RXInstructionImgModel.h"

@implementation RXInstructionImgModel


- (instancetype)initWithURL:(NSString*) url andTitle:(NSString*) title
{
    self = [super init];
    if (self) {
        self.url = url;
        self.title = title;
    }
    return self;
}

@end
