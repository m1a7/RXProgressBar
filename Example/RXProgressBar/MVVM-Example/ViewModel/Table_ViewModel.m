//
//  Table_ViewModel.m
//  RXProgressBar_Example
//
//  Created by Uber on 27/02/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import "Table_ViewModel.h"

// RXProgressBar
#import <RXProgressBar/RXProgressBar.h>

// RXUIConfig
#import <RXProgressBar/RXUIConfig.h>

// RXIndexPath
#import <RXProgressBar/RXIndexPath.h>

// Models from RXProgressBar for work with images
#import <RXProgressBar/RXInstructionImgModel.h>
#import <RXProgressBar/RXInstructionModel.h>
#import <RXLayoutGallary/RXExtendedImage.h>

// ViewModels of cell
#import <RXProgressBar/RXMiddleViewModelCell.h>

// Pseudo datasource for example
#import "DataBuilder.h"


@implementation Table_ViewModel

/*
 Init all require components (arrays,object ect..) before using
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellsArray   = [NSMutableArray array];
        self.pbCollection = [RXCollectionPB new];
        self.imageCache   = [NSCache new];
    }
    return self;
}

#pragma mark - Work with API

- (void) getDataFromURL:(NSString*) url
              onSuccess:(void(^)(BOOL successOperation)) success
              onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure
{
    
    // Get array with object which conform with protocol "RXInstructionModelProtocol"
    NSArray<id<RXInstructionModelProtocol>>* arrStepByStep = [DataBuilder createPumkinInstruction];

    // Create first RXProgressBar(aka."Instruction") with reference on RXCollectionPB (aka. "super collection")
    RXProgressBar* bar = [[RXProgressBar alloc] initWithCollectionPB:  self.pbCollection addAdditionalBeginAndEndCells: YES];
    
    // Select ui style for our RXProgressBar
    bar.configUI       = [[RXUIConfig alloc] initConfigWithStyle: RXProgressBarStyle5];

    
    /*
    bar.configUI       = [[RXUIConfig alloc] initConfigWithCustomStyle:^(RXUIConfig *config) {
        // Follow this style.
        config.widthPercentCheckPointAndLine     = 10.f;
        config.widthPercentInstructionAndGallary = 90.f;
        config.mainLabelFont = [UIFont fontWithName:@"Arial" size:12.f];
        
        // General property
        config.mainLabelFontColor      = [UIColor yellowColor];
       
        config.backgroundColorForCell          = [UIColor darkGrayColor];
        config.backgroundColorForDoneCell      = [UIColor darkGrayColor];
        config.backgroundColorForProcessCell   = [UIColor darkGrayColor];
        config.backgroundColorForWaitingCell   = [UIColor darkGrayColor];
        
        // CheckPoint - Done State
        config.doneCheckPointBackgroundColor = [UIColor whiteColor];  // Background Color - Green
        config.doneCheckPointBorderColor     = [UIColor lightGrayColor];  // Color Border
        config.doneCheckPointBorderWidth     = 0.5f;                                        // Width Border
        
        // CheckPoint - InProcess State
        config.inProcessCheckPointBackgroundColor  = [UIColor purpleColor];                        // Background Color
        config.inProcessCheckPointBorderColor      = [UIColor redColor ];  // Color Border
        config.inProcessCheckPointBorderWidth      = 1.5f;                                        // Width Border
        
        // CheckPoint - InWaiting State
        config.inWaitingCheckPointBackgroundColor = [UIColor redColor];  // Background Color
        
        // Shared properties for CheckPoint
        config.checkPointRoundDegree = RXRoundCircle;
        
        // LineColor - Done State
        config.doneLineColorBackgroundColor = [UIColor blueColor];      // Background Color
        // LineColor - InProcess State
        config.inProcessLineColorBackgroundColor = [UIColor brownColor];  // Background Color
        // LineColor - InWaiting State
        config.inWaitingLineColorBackgroundColor = [UIColor orangeColor];  // Background Color
        
        // Shared properties for LineColor
        // LineCololr Top & Bottom offset In Percent
        config.percentOffsetFromTop    = 0;
        config.percentOffsetFromBottom = 0;
    }];
     */
    
     // Transform (object which conform with protocol "RXInstructionModelProtocol") to -> RXProgressBar's private viewmodel's cells
    NSArray* arrVMFromPB = [bar createVMfromModelsArray: arrStepByStep withRefOnImgCache:self.imageCache];
    
    // Add these viewmodels to tableview datasource array
    [self.cellsArray addObjectsFromArray: arrVMFromPB];
    [self.pbCollection addPB: bar];
}

#pragma mark - Methods for TableView work

- (id) cellViewModel:(NSInteger) index{
    
    if (self.cellsArray.count > index){
        return self.cellsArray[index];
    }
    return nil;
}

- (NSInteger) countViewModels {
    return self.cellsArray.count;
}


#pragma mark - Deleting cells

- (void) deleteVMfromCellsArrayByIndexPath:(RXIndexPath*) path
{
    if (self.cellsArray.count > path.row)
    {
        id vm = self.cellsArray[path.row];
        if ([vm isKindOfClass:[RXBaseViewModelCell class]])
        {
            RXBaseViewModelCell* convertVM = (RXBaseViewModelCell*)vm;
            [convertVM deleteRow];
            [self.cellsArray removeObject:vm];
        }
    }
}

- (BOOL) canDeleteRowAtRXIndexPath:(RXIndexPath*) indexPath{
  // Give permission for the removal of a given cell
    return YES;
}


@end
