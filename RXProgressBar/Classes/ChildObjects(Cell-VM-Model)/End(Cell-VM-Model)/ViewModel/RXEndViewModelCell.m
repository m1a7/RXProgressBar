//
//  RXEndViewModelCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXEndViewModelCell.h"
#import "RXProgressBar.h"
#import "RXUIConfig.h"


@implementation RXEndViewModelCell

-(instancetype) initWithModel:(id<RXBaseCellModelProtocol>) model withProgressBar:(RXProgressBar*) pb
{
    self = [super init];
    if (self) {
        self.progressBar = pb;
    }
    return self;
}

- (float) getTotalHeightWithOffset:(float) offset
{
    if (self.height_CheckPoint >= (self.progressBar.configUI.customBeginCellHeight || self.progressBar.configUI.standartBeginCellHeight)){
        return self.height_CheckPoint += offset*2;
    }
    
    if (self.progressBar.configUI.customEndCellHeight > self.progressBar.configUI.standartBeginCellHeight){
        return self.progressBar.configUI.customEndCellHeight;
    }
    return self.progressBar.configUI.standartBeginCellHeight;
}


@end
