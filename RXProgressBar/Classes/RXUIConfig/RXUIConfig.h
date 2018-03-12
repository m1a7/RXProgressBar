//
//  RXUIConfig.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

@import UIKit;

typedef enum ProgressBarStyle {
    
    RXProgressBarStyle1,
    RXProgressBarStyle2,
    RXProgressBarStyle3,
    RXProgressBarStyle4,
    RXProgressBarStyle5
    
} RXProgressBarStyle;


@interface RXUIConfig : NSObject

/*
@property (assign, nonatomic) float
@property (strong, nonatomic) UIColor*
@property (strong, nonatomic) UIFont*
@property (strong, nonatomic) UIImage*
*/

@property (assign, nonatomic) RXProgressBarStyle pbStyle;

@property (assign, nonatomic) float percentOnScreenForVerticaLineAndCheckPoint;
@property (assign, nonatomic) float percentOnScreenForMainLabelAndPhotoGallary;

@property (strong, nonatomic) UIColor* doneCheckPointColor;
@property (strong, nonatomic) UIColor* inProcessCheckPointColor;
@property (strong, nonatomic) UIColor* inWaitingCheckPointColor;

@property (strong, nonatomic) UIColor* doneLineColor;
@property (strong, nonatomic) UIColor* inProcessLineColor;
@property (strong, nonatomic) UIColor* lineColor;

@property (strong, nonatomic) UIColor* doneCheckPointBorderColor;
@property (strong, nonatomic) UIColor* inProcessCheckPointBorderColor;
@property (strong, nonatomic) UIColor* inWaitingCheckPointBorderColor;
@property (strong, nonatomic) UIColor* checkPointBorderColor;

@property (assign, nonatomic) float borderWidthDoneCheckPoint;
@property (assign, nonatomic) float borderWidthInProcessCheckPoint;
@property (assign, nonatomic) float borderWidthInWaitingCheckPoint;
@property (assign, nonatomic) float borderWidth;

@property (assign, nonatomic) float cornerRadiusCheckPoint;

@property (assign, nonatomic) float offsetFromTopForLine;
@property (assign, nonatomic) float offsetFromBottomForLine;

@property (strong, nonatomic) UIFont* doneCheckPointFont;
@property (strong, nonatomic) UIFont* inProcessCheckPointFont;
@property (strong, nonatomic) UIFont* inWaitingCheckPointFont;
@property (strong, nonatomic) UIFont* checkPointFont;

@property (strong, nonatomic) UIImage* doneCheckPointImage;
@property (strong, nonatomic) UIImage* inWaitingCheckPointImage;
@property (strong, nonatomic) UIImage* inProcessCheckPointImage;
@property (strong, nonatomic) UIImage* checkPointImage;

@property (assign, nonatomic) float customBeginCellHeight;
@property (assign, nonatomic) float customEndCellHeight;

@property (assign, nonatomic) float standartBeginCellHeight;
@property (assign, nonatomic) float standartEndCellHeight;

@property (strong, nonatomic) UIFont* mainLabelFont;
@property (strong, nonatomic) UIColor* backgroundColorForCell;


@end
