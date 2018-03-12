//
//  RXProgressBar.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

#import "RXInstructionModelProtocol.h"

@class RXBaseViewModelCell;
@class RXCollectionPB;
@class RXUIConfig;


@interface RXProgressBar : NSObject

@property(strong, nonatomic) NSMutableArray* allViewModels; // Here store all cell's viewModels (RXBeginViewModelCell,RXMiddleViewModelCell,RXEndViewModelCell)
@property(weak,   nonatomic) RXCollectionPB* superCollection; //  Here store our this RXProgressBar
@property(strong, nonatomic) RXUIConfig* configUI;              // This object need for setting ui configuration our RXProgressBar
@property(assign, nonatomic) BOOL addAdditionalBeginAndEndCells; // You decide to add additional cells from the end and start, or not


- (instancetype)initWithCollectionPB:(RXCollectionPB*) collectionPB addAdditionalBeginAndEndCells:(BOOL) additionalBeginAndEndCells; //NS_DESIGNATED_INITIALIZER


- (void) deleteRow:(RXBaseViewModelCell*) vm; // Detele only one some cell from tableview

- (void) deleteProgressBar;                  // Delete all rxprogressbar's cells from parent tableview

/*
   Transform (object which conform with protocol "RXInstructionModelProtocol") to -> RXProgressBar's private viewmodel's cells
*/
- (NSArray*) createVMfromModelsArray:(NSArray<id <RXInstructionModelProtocol>>*) arrWithModels withRefOnImgCache:(NSCache*) cache;

@end
