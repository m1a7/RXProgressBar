//
//  RXProgressBar.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

#import "RXCollectionPB.h"
#import "RXUIConfig.h"

#import "RXInstructionModelProtocol.h"

#import "RXBaseViewModelCell.h"

@interface RXProgressBar : NSObject

@property(strong, nonatomic) NSMutableArray* allViewModels;
@property(weak,   nonatomic) RXCollectionPB* superCollection;
@property(strong, nonatomic) RXUIConfig* configUI;
@property(assign, nonatomic) BOOL addAdditionalBeginAndEndCells;


- (instancetype)initWithCollectionPB:(RXCollectionPB*) collectionPB addAdditionalBeginAndEndCells:(BOOL) additionalBeginAndEndCells;

- (void) deleteRow:(RXBaseViewModelCell*) vm;

- (void) deleteProgressBar;

- (NSArray*) createVMfromModelsArray:(NSArray<id <RXInstructionModelProtocol>>*) arrWithModels;

@end
