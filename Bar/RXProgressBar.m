//
//  RXProgressBar.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXProgressBar.h"

#import "RXBeginViewModelCell.h"
#import "RXMiddleViewModelCell.h"
#import "RXEndViewModelCell.h"


@implementation RXProgressBar

- (instancetype)initWithCollectionPB:(RXCollectionPB*) collectionPB addAdditionalBeginAndEndCells:(BOOL) additionalBeginAndEndCells
{
    self = [super init];
    if (self) {
        self.allViewModels = [NSMutableArray new];
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

-(NSArray*) createVMfromModelsArray:(NSArray<id <RXInstructionModelProtocol>>*) arrWithModels
{
    for (id< RXInstructionModelProtocol>obj in arrWithModels)
    {
        RXMiddleViewModelCell* vm = [[RXMiddleViewModelCell alloc] initWithModel: obj
                                                                 withProgressBar: self];
        [self.allViewModels addObject: vm];
    }
    
    if (self. addAdditionalBeginAndEndCells) {
    
#warning  Пофиксить нилы
        RXBeginViewModelCell* beginVM  = [[RXBeginViewModelCell alloc] initWithModel:nil withProgressBar:self];
        RXEndViewModelCell*   endVM    = [[RXEndViewModelCell alloc]   initWithModel:nil withProgressBar:self];
        
        [self.allViewModels insertObject: beginVM atIndex: 0];
        [self.allViewModels insertObject: endVM   atIndex:
         [_allViewModels indexOfObject: [_allViewModels lastObject] ]];
    }
    return self.allViewModels;
}

@end
