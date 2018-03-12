//
//  RXCollectionPB.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXCollectionPB.h"

#import "RXProgressBar.h"

@implementation RXCollectionPB


- (void) deleteProgressBar:(RXProgressBar*) bar{
    [self.pbArr removeObject: bar];
}

- (void) addPB:(RXProgressBar*) bar{
    [self.pbArr addObject: bar];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.pbArr = [NSMutableArray new];
    }
    return self;
}

@end
