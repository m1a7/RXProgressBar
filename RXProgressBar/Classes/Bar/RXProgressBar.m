//
//  RXProgressBar.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXProgressBar.h"

#import "RXBaseViewModelCell.h"
#import "RXCollectionPB.h"
#import "RXUIConfig.h"

// ViewModel
#import "RXBeginViewModelCell.h"
#import "RXMiddleViewModelCell.h"
#import "RXEndViewModelCell.h"

// Model
#import "RXBeginCellModel.h"
#import "RXEndCellModel.h"

@implementation RXProgressBar

- (instancetype)initWithCollectionPB:(RXCollectionPB*) collectionPB addAdditionalBeginAndEndCells:(BOOL) additionalBeginAndEndCells
{
    self = [super init];
    if (self) {
        self.allViewModels                   = [NSMutableArray new];
        self. addAdditionalBeginAndEndCells  = additionalBeginAndEndCells;
    }
    return self;
}



- (void) deleteRow:(RXBaseViewModelCell*) vm
{
    [self.allViewModels removeObject: vm];
}

- (void) deleteProgressBar
{
    [self.allViewModels removeAllObjects];
    [self.superCollection deleteProgressBar: self];
}

- (NSArray*) createVMfromModelsArray:(NSArray<id <RXInstructionModelProtocol>>*) arrWithModels withRefOnImgCache:(NSCache*) cache
{
    // On start we have array of objects which confrom "RXInstructionModelProtocol"
    // Further we will create cell's viewmodels from these object
    
    for (id< RXInstructionModelProtocol>obj in arrWithModels)
    {
        // First create a MiddleViewModelCell
        /*
          RXMiddleViewModelCell - this is viewmodel for cell with text and images
        */
        RXMiddleViewModelCell* vm = [[RXMiddleViewModelCell alloc] initWithModel: obj
                                                                 withProgressBar: self];
        // Setup cache for images
        vm.imageCache = cache;
        
        
        // Set status for cell
        // Status is need for draw cell in correct color
        
        /*
         If this "obj" have first position in array.
         Then we set status -"RXStatusCellIsDone" - like "This cell already was a read"
        */
        if ([arrWithModels indexOfObject:obj] == 0){
            vm.cellStatus = RXStatusCellIsDone;
        
        /*
         If this "obj" have  second position in array.
         Then we set status -"RXStatusCellIsInProcess" - like "This is a cell in the process of studying"
         */
        } else if (([arrWithModels indexOfObject:obj] == 1)) {
            vm.cellStatus = RXStatusCellIsInProcess;
        
            /*
             If this "obj" have  thrid and greater position in array.
             Then we set status -"RXStatusCellIsInWaiting" - like "This cell is pending consideration"
             */
        } else {
            vm.cellStatus = RXStatusCellIsInWaiting;
        }
        
        [self.allViewModels addObject: vm];
    }
    
    // If you want, fraemwork can and begin cell and end cell :)
    if (self. addAdditionalBeginAndEndCells) {
    
        RXBeginCellModel* beginModel  = [[RXBeginCellModel alloc] init];
        RXEndCellModel*   endModel    = [[RXEndCellModel alloc] init];
        
        RXBeginViewModelCell* beginVM  = [[RXBeginViewModelCell alloc] initWithModel:beginModel withProgressBar:self];
        RXEndViewModelCell*   endVM    = [[RXEndViewModelCell alloc]   initWithModel:endModel   withProgressBar:self];
        beginVM.cellStatus = RXStatusCellIsDone;
        endVM.cellStatus   = RXStatusCellIsInWaiting;

        [self.allViewModels insertObject: beginVM atIndex: 0];
        [self.allViewModels addObject: endVM];
    }
    return self.allViewModels;
}

@end
