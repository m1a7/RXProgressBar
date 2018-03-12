//
//  RXUIConfig.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXUIConfig.h"

@implementation RXUIConfig

-(instancetype) initConfigWithStyle:(RXProgressBarStyle) style
{
    self = [super init];
    if (self) {
        [self setupConfigByStyle: style];
        self.pbStyle = style;
    }
    return self;
}

- (void) setupConfigByStyle:(RXProgressBarStyle) style
{
    switch (style) {
        case RXProgressBarStyle1: [self configByStyle1]; break;
        case RXProgressBarStyle2: [self configByStyle2]; break;
        case RXProgressBarStyle3: [self configByStyle3]; break;
        case RXProgressBarStyle4: [self configByStyle4]; break;
        case RXProgressBarStyle5: [self configByStyle5]; break;
            
        default: NSLog(@"Not found style"); break;
    }
}

#pragma mark - Setters

-(void) setPercentOnScreenForVerticaLineAndCheckPoint:(float)percentOnScreenForVerticaLineAndCheckPoint
{
    if (percentOnScreenForVerticaLineAndCheckPoint >= 0 && percentOnScreenForVerticaLineAndCheckPoint <= 100)
    {
        _percentOnScreenForVerticaLineAndCheckPoint = percentOnScreenForVerticaLineAndCheckPoint;
    } else {
        NSLog(@"Attempt to set wrong value");
    }
}

-(void) setPercentOnScreenForMainLabelAndPhotoGallary:(float)percentOnScreenForMainLabelAndPhotoGallary
{
    if (percentOnScreenForMainLabelAndPhotoGallary >= 0 && percentOnScreenForMainLabelAndPhotoGallary <= 100)
    {
        _percentOnScreenForMainLabelAndPhotoGallary = percentOnScreenForMainLabelAndPhotoGallary;
    } else {
        NSLog(@"Attempt to set wrong value");
    }
}

#pragma mark - Set style to object

-(void) configByStyle1 { }
-(void) configByStyle2 { }
-(void) configByStyle3 { }
-(void) configByStyle4 { }
-(void) configByStyle5 { }

@end
