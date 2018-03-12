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
    RXProgressBarStyle5,
    RXProgressBarCustomStyle
    
} RXProgressBarStyle;


typedef enum  degreeOfCurvatureCheckPoint {
   RXRoundCircle,
   RXRoundSquard
} RXRoundDegree;


@interface RXUIConfig : NSObject


// Init method with ui style with one of the list RXProgressBarStyle
- (instancetype) initConfigWithStyle:(RXProgressBarStyle) style;

// Init method with custom ui style
- (instancetype) initConfigWithCustomStyle:(void (^)(RXUIConfig* config))setCustomStyleBlock;


// General property
@property (assign, nonatomic) RXProgressBarStyle pbStyle;
@property (assign, nonatomic) float standartOffSetBetweenUIComponents;

@property (assign, nonatomic) float widthPercentCheckPointAndLine;
@property (assign, nonatomic) float widthPercentInstructionAndGallary;


// Font for "InstructionLabel"
@property (strong, nonatomic) UIFont* mainLabelFont;
@property (strong, nonatomic) UIColor* mainLabelFontColor;

// Color for BackgroundColor Cell
@property (strong, nonatomic) UIColor* backgroundColorForCell;
@property (strong, nonatomic) UIColor* backgroundColorForDoneCell;
@property (strong, nonatomic) UIColor* backgroundColorForProcessCell;
@property (strong, nonatomic) UIColor* backgroundColorForWaitingCell;


// Standart Height for Begin & End Cells
@property (assign, nonatomic) float standartBeginCellHeight;
@property (assign, nonatomic) float standartEndCellHeight;

// Custom Height for Begin & End Cells
@property (assign, nonatomic) float customBeginCellHeight;
@property (assign, nonatomic) float customEndCellHeight;

// CheckPoint - Done State
@property (strong, nonatomic) UIColor* doneCheckPointBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* doneCheckPointBorderColor;      // Color Border
@property (assign, nonatomic) float    doneCheckPointBorderWidth;      // Width Border
@property (strong, nonatomic) UIFont*  doneCheckPointFont;             // Font
@property (strong, nonatomic) UIColor* doneCheckPointFontColor;        // Font Color
@property (strong, nonatomic) UIImage* doneCheckPointImage;            // UIImage

// CheckPoint - InProcess State
@property (strong, nonatomic) UIColor* inProcessCheckPointBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* inProcessCheckPointBorderColor;      // Color Border
@property (assign, nonatomic) float    inProcessCheckPointBorderWidth;      // Width Border
@property (strong, nonatomic) UIFont*  inProcessCheckPointFont;             // Font
@property (strong, nonatomic) UIColor*  inProcessCheckPointFontColor;       // Font Color
@property (strong, nonatomic) UIImage* inProcessCheckPointImage;            // UIImage

// CheckPoint - InWaiting State
@property (strong, nonatomic) UIColor* inWaitingCheckPointBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* inWaitingCheckPointBorderColor;      // Color Border
@property (assign, nonatomic) float    inWaitingCheckPointBorderWidth;      // Width Border
@property (strong, nonatomic) UIFont*  inWaitingCheckPointFont;             // Font
@property (strong, nonatomic) UIColor* inWaitingCheckPointFontColor;       // Font Color
@property (strong, nonatomic) UIImage* inWaitingCheckPointImage;            // UIImage

// Shared properties for CheckPoint
@property (assign, nonatomic) RXRoundDegree checkPointRoundDegree;


// LineColor - Done State
@property (strong, nonatomic) UIColor* doneLineColorBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* doneLineColorBorderColor;      // Color Border
@property (assign, nonatomic) float    doneLineColorBorderWidth;      // Width Border

// LineColor - InProcess State
@property (strong, nonatomic) UIColor* inProcessLineColorBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* inProcessLineColorBorderColor;      // Color Border
@property (assign, nonatomic) float    inProcessLineColorBorderWidth;      // Width Border

// LineColor - InWaiting State
@property (strong, nonatomic) UIColor* inWaitingLineColorBackgroundColor;  // Background Color
@property (strong, nonatomic) UIColor* inWaitingLineColorBorderColor;      // Color Border
@property (assign, nonatomic) float    inWaitingLineColorBorderWidth;      // Width Border

// Shared properties for LineColor
// LineCololr Top & Bottom offset
@property (assign, nonatomic) float percentOffsetFromTop;
@property (assign, nonatomic) float percentOffsetFromBottom;


@end
