//
//  RXBeginViewModelCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBeginViewModelCell.h"

#import "RXProgressBar.h"

@implementation RXBeginViewModelCell

- (void) deleteRow {
    [self.progressBar deleteRow: self];
}

- (void) deleteAllRowsAtProgressBar {
    [self.progressBar deleteProgressBar];
}

- (float) getTotalHeightWithOffset:(float) offset {
    return 1.f;
}

- (instancetype)initWithModel:(id< RXInstructionModelProtocol>) model withProgressBar:(RXProgressBar*) pb{
    self = [super init];
    if (self) {
        self.progressBar = pb;
    }
    return self;
}



@end
