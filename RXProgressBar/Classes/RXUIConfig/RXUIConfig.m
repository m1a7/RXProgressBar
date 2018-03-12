//
//  RXUIConfig.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXUIConfig.h"

#import "RXProgressBar.h"

@implementation RXUIConfig




-(instancetype) initConfigWithStyle:(RXProgressBarStyle) style
{
    self = [super init];
    if (self) {
        self.pbStyle = style;
        self.standartOffSetBetweenUIComponents = 15.f;
        self.widthPercentCheckPointAndLine     = 8.f;
        self.widthPercentInstructionAndGallary = 92.f;
        
        self.mainLabelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:14.f]; // Font for "InstructionLabel"
      
        // Color for BackgroundColor Cell
        self.backgroundColorForCell = [UIColor yellowColor];
        self.backgroundColorForDoneCell      = [UIColor whiteColor];
        self.backgroundColorForProcessCell   = [UIColor whiteColor];
        self.backgroundColorForWaitingCell   = [UIColor whiteColor];
        
        // Standart Height for Begin & End Cells
        self.standartBeginCellHeight = 50.f;
        self.standartEndCellHeight   = 50.f;
        
        [self setupConfigByStyle: style];
    }
    return self;
}

- (instancetype) initConfigWithCustomStyle:(void (^)(RXUIConfig* config))setCustomStyleBlock
{
    self = [super init];
    if (self) {
        setCustomStyleBlock(self);
        self.pbStyle = RXProgressBarCustomStyle;
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

-(void) setWidthPercentCheckPointAndLine:(float)widthPercentCheckPointAndLine
{
    if (widthPercentCheckPointAndLine >= 0 && widthPercentCheckPointAndLine <= 100)
    {
        _widthPercentCheckPointAndLine = widthPercentCheckPointAndLine;
    } else {
        NSLog(@"Attempt to set wrong value");
    }
}

-(void) setWidthPercentInstructionAndGallary:(float)widthPercentInstructionAndGallary
{
    if (widthPercentInstructionAndGallary >= 0 && widthPercentInstructionAndGallary <= 100)
    {
        _widthPercentInstructionAndGallary = widthPercentInstructionAndGallary;
    } else {
        NSLog(@"Attempt to set wrong value");
    }
}

#pragma mark - Set style to object


-(void) configByStyle1 {
    
    // General property
    self.mainLabelFontColor              = [UIColor blackColor];
    self.backgroundColorForCell          = [UIColor whiteColor];
    self.backgroundColorForDoneCell      = [UIColor whiteColor];
    self.backgroundColorForProcessCell   = [UIColor whiteColor];
    self.backgroundColorForWaitingCell   = [UIColor whiteColor];
    
    // CheckPoint - Done State
    self.doneCheckPointBackgroundColor = [RXUIConfig colorFromHexString:@"#53CB6D"];  // Background Color - Green
    self.doneCheckPointBorderColor     = [RXUIConfig colorFromHexString:@"#53CB6D"];  // Color Border
    self.doneCheckPointBorderWidth     = 0.5f;                                        // Width Border

    // CheckPoint - InProcess State
    self.inProcessCheckPointBackgroundColor  = [UIColor whiteColor];                        // Background Color
    self.inProcessCheckPointBorderColor      = [RXUIConfig colorFromHexString:@"#74ABD0"];  // Color Border
    self.inProcessCheckPointBorderWidth      = 1.5f;                                        // Width Border
    
    // CheckPoint - InWaiting State
    self.inWaitingCheckPointBackgroundColor = [RXUIConfig colorFromHexString:@"#E0E0E0"];  // Background Color
  
    // Shared properties for CheckPoint
    self.checkPointRoundDegree = RXRoundCircle;
    
    // LineColor - Done State
    self.doneLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#53CB6D"];      // Background Color
    // LineColor - InProcess State
    self.inProcessLineColorBackgroundColor = [UIColor lightGrayColor];  // Background Color
    // LineColor - InWaiting State
    self.inWaitingLineColorBackgroundColor = [UIColor lightGrayColor];  // Background Color
    
    // Shared properties for LineColor
    // LineCololr Top & Bottom offset In Percent
     self.percentOffsetFromTop    = 3;
     self.percentOffsetFromBottom = 3;
}

-(void) configByStyle2 {
    
    // General property
    self.mainLabelFontColor              = [UIColor blackColor];
    self.backgroundColorForCell          = [UIColor whiteColor];
    self.backgroundColorForDoneCell      = [UIColor whiteColor];
    self.backgroundColorForProcessCell   = [UIColor whiteColor];
    self.backgroundColorForWaitingCell   = [UIColor whiteColor];
    
    // CheckPoint - Done State
    self.doneCheckPointBackgroundColor = [UIColor whiteColor];                        // Background Color
    self.doneCheckPointBorderColor     = [RXUIConfig colorFromHexString:@"#29D089"];  // Color Border
    self.doneCheckPointBorderWidth     = 1.5f;                                        // Width Border
    
    // CheckPoint - InProcess State
    self.inProcessCheckPointBackgroundColor  = [UIColor whiteColor];                        // Background Color
    self.inProcessCheckPointBorderColor      = [RXUIConfig colorFromHexString:@"#D8D8D8"];  // Color Border
    self.inProcessCheckPointBorderWidth      = 1.5f;                                        // Width Border
    
    // CheckPoint - InWaiting State
    self.inWaitingCheckPointBackgroundColor = [UIColor whiteColor];       // Background Color
    self.inWaitingCheckPointBorderColor     = [UIColor lightGrayColor];   // Color Border
    self.inWaitingCheckPointBorderWidth     = 1.5f;                       // Width Border
    
    // Shared properties for CheckPoint
    self.checkPointRoundDegree = RXRoundCircle;

    // LineColor - Done State
    self.doneLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#29D089"];     // Background Color
    // LineColor - InProcess State
    self.inProcessLineColorBackgroundColor = [UIColor lightGrayColor];                  // Background Color
    // LineColor - InWaiting State
    self.inWaitingLineColorBackgroundColor = [UIColor lightGrayColor];                  // Background Color
    
    // Shared properties for LineColor
    // LineCololr Top & Bottom offset
    self.percentOffsetFromTop    = 0;
    self.percentOffsetFromBottom = 0;
}


-(void) configByStyle3 {
    // General property
    self.mainLabelFontColor              = [UIColor blackColor];
    self.backgroundColorForCell          = [UIColor whiteColor];
    self.backgroundColorForDoneCell      = [UIColor whiteColor];
    self.backgroundColorForProcessCell   = [UIColor whiteColor];
    self.backgroundColorForWaitingCell   = [UIColor whiteColor];
    
    // CheckPoint - Done State
    self.doneCheckPointBackgroundColor = [RXUIConfig colorFromHexString:@"#2FCB6F"];    // Background Color
    self.doneCheckPointBorderColor     =  [RXUIConfig colorFromHexString:@"#2FCB6F"];   // Color Border
    self.doneCheckPointBorderWidth     = 1.5f;                                          // Width Border
    self.doneCheckPointFont            = [UIFont fontWithName:@"AvenirNext-Light" size:12.f];
    self.doneCheckPointFontColor       = [UIColor whiteColor];


    // CheckPoint - InProcess State
    self.inProcessCheckPointBackgroundColor  = [RXUIConfig colorFromHexString:@"#3498db"];  // Background Color
    self.inProcessCheckPointBorderColor      = [RXUIConfig colorFromHexString:@"#3498db"];  // Color Border
    self.inProcessCheckPointBorderWidth      = 1.5f;                                        // Width Border
    self.inProcessCheckPointFont             = [UIFont fontWithName:@"AvenirNext-Light" size:12.f];
    self.inProcessCheckPointFontColor        = [UIColor whiteColor];

    // CheckPoint - InWaiting State
    self.inWaitingCheckPointBackgroundColor = [RXUIConfig colorFromHexString:@"#E1E6E6"];   // Background Color
    self.inWaitingCheckPointBorderColor     = [RXUIConfig colorFromHexString:@"#E1E6E6"];   // Color Border
    self.inWaitingCheckPointBorderWidth     = 1.5f;                                         // Width Border
    self.inWaitingCheckPointFont            = [UIFont fontWithName:@"AvenirNext-Light" size:12.f];
    self.inWaitingCheckPointFontColor       = [RXUIConfig colorFromHexString:@"#849397"];
    
    // Shared properties for CheckPoint
    self.checkPointRoundDegree = RXRoundCircle;
    
    // LineColor - Done State
    self.doneLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#2FCB6F"];       // Background Color
    // LineColor - InProcess State
    self.inProcessLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#E1E6E6"];  // Background Color
    // LineColor - InWaiting State
    self.inWaitingLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#E1E6E6"];  // Background Color
    
    // Shared properties for LineColor
    // LineCololr Top & Bottom offset
    self.percentOffsetFromTop    = 0;
    self.percentOffsetFromBottom = 0;
}

// Squard checkPoint
-(void) configByStyle4 {
    
    // General property
    self.mainLabelFontColor              = [UIColor blackColor];
    self.backgroundColorForCell          = [UIColor whiteColor];
    self.backgroundColorForDoneCell      = [UIColor whiteColor];
    self.backgroundColorForProcessCell   = [UIColor whiteColor];
    self.backgroundColorForWaitingCell   = [UIColor whiteColor];
    
    // CheckPoint - Done State
    self.doneCheckPointBackgroundColor = [RXUIConfig colorFromHexString:@"#2CB665"];  // Background Color
    self.doneCheckPointBorderColor     = [RXUIConfig colorFromHexString:@"#2CB665"];  // Color Border
    self.doneCheckPointBorderWidth     = 0.5f;                                        // Width Border
    self.doneCheckPointFont            = [UIFont fontWithName:@"AvenirNext-Regular" size:12.f];
    self.doneCheckPointFontColor       = [UIColor whiteColor];

    
    // CheckPoint - InProcess State
    self.inProcessCheckPointBackgroundColor  = [UIColor whiteColor];      // Background Color
    self.inProcessCheckPointBorderColor      = [UIColor lightGrayColor];  // Color Border
    self.inProcessCheckPointBorderWidth      = 0.5f;                      // Width Border
    self.inProcessCheckPointFont             = [UIFont fontWithName:@"AvenirNext-Regular" size:12.f];
    self.inProcessCheckPointFontColor        = [UIColor darkGrayColor];
    
    // CheckPoint - InWaiting State
    self.inWaitingCheckPointBackgroundColor = [UIColor whiteColor];       // Background Color
    self.inWaitingCheckPointBorderColor     = [UIColor lightGrayColor];   // Color Border
    self.inWaitingCheckPointBorderWidth     = 0.5f;                       // Width Border
    self.inWaitingCheckPointFont            = [UIFont fontWithName:@"AvenirNext-Regular" size:12.f];
    self.inWaitingCheckPointFontColor       = [UIColor darkGrayColor];
    
    // Shared properties for CheckPoint
    self.checkPointRoundDegree = RXRoundSquard;
    // ----------------------------  //
    
    // LineColor - Done State
    self.doneLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#2CB665"];      // Background Color
    // LineColor - InProcess State
    self.inProcessLineColorBackgroundColor = [UIColor lightGrayColor];                   // Background Color
    // LineColor - InWaiting State
    self.inWaitingLineColorBackgroundColor = [UIColor lightGrayColor];                   // Background Color
    
    // Shared properties for LineColor
    // LineCololr Top & Bottom offset
    self.percentOffsetFromTop    = 0;
    self.percentOffsetFromBottom = 0;
}


-(void) configByStyle5 {
    
    // General property
   self.mainLabelFontColor              = [UIColor whiteColor];
   self.backgroundColorForCell          = [UIColor blackColor];
   self.backgroundColorForDoneCell      = [UIColor blackColor];
   self.backgroundColorForProcessCell   = [UIColor blackColor];
   self.backgroundColorForWaitingCell   = [UIColor blackColor];
    
    // CheckPoint - Done State
    self.doneCheckPointImage = [self optimizedImageFromImage:[UIImage imageNamed:@"green"]];
    
    // CheckPoint - InProcess State
    self.inProcessCheckPointBackgroundColor  = [UIColor whiteColor];      // Background Color
    self.inProcessCheckPointBorderColor      = [UIColor lightGrayColor];  // Color Border
    self.inProcessCheckPointBorderWidth      = 0.5f;                      // Width Border
    self.inProcessCheckPointFont             = [UIFont fontWithName:@"AvenirNext-Regular" size:12.f];
    self.inProcessCheckPointFontColor        = [UIColor darkGrayColor];
    
    // CheckPoint - InWaiting State
    self.inWaitingCheckPointBackgroundColor = [UIColor whiteColor];       // Background Color
    self.inWaitingCheckPointBorderColor     = [UIColor lightGrayColor];   // Color Border
    self.inWaitingCheckPointBorderWidth     = 0.5;                        // Width Border
    self.inWaitingCheckPointFont            = [UIFont fontWithName:@"AvenirNext-Regular" size:12.f];
    self.inWaitingCheckPointFontColor       = [UIColor darkGrayColor];
    
    
    // Shared properties for CheckPoint
    self.checkPointRoundDegree = RXRoundCircle;
    
    // LineColor - Done State
    self.doneLineColorBackgroundColor = [RXUIConfig colorFromHexString:@"#2FCB6F"];     // Background Color
    // LineColor - InProcess State
    self.inProcessLineColorBackgroundColor = [UIColor lightGrayColor];                  // Background Color
    // LineColor - InWaiting State
    self.inWaitingLineColorBackgroundColor = [UIColor lightGrayColor];                  // Background Color
    
    // Shared properties for LineColor
    // LineCololr Top & Bottom offset
    self.percentOffsetFromTop    = 0;
    self.percentOffsetFromBottom = 0;
}

#pragma mark - Helpers

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (UIImage *)optimizedImageFromImage:(UIImage *)image
{
    CGSize imageSize = image.size;
    UIGraphicsBeginImageContextWithOptions( imageSize, YES, image.scale );
    [image drawInRect: CGRectMake( 0, 0, imageSize.width, imageSize.height )];
    UIImage *optimizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return optimizedImage;
}



@end
