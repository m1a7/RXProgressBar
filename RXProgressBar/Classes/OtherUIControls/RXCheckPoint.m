//
//  RXCheckPoint.m
//  RXProgressBar
//
//  Created by Uber on 03/03/2018.
//

#import "RXCheckPoint.h"

@implementation RXCheckPoint


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.drawsAsynchronously = YES;
        self.layer.masksToBounds       = YES;
        self.numberOfLines             = 1;
        self.adjustsFontSizeToFitWidth = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];

    if (self.roundType == RXRoundSquard){
        super.layer.cornerRadius  = CGRectGetHeight(frame)/6;
    }
    if (self.roundType == RXRoundCircle){
        super.layer.cornerRadius  = CGRectGetHeight(frame)/2;
    }
}



@end
