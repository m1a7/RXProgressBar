//
//  RXIndexPath.m
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import "RXIndexPath.h"

@implementation RXIndexPath

- (instancetype)initWithRow:(NSInteger) row withSection:(NSInteger) section
{
    self = [super init];
    if (self) {
        self.row     = row;
        self.section = section;
    }
    return self;
}

@end
