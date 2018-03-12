//
//  Table_ViewModel.h
//  RXProgressBar_Example
//
//  Created by Uber on 27/02/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import <Foundation/Foundation.h>

// Require components from RXProgressBar fraemwork
#import <RXProgressBar/RXCollectionPB.h>
@class RXIndexPath;


@interface Table_ViewModel : NSObject

@property(nonatomic, strong) NSMutableArray* cellsArray;   // Array with Cell's ViewModels
@property(nonatomic, strong) RXCollectionPB* pbCollection; // Super collection RXProgressBar. Here store all RXProgressBar from our uitableview
@property(nonatomic, strong) NSCache* imageCache;          // In this cache - store all gif images from all RXProgressBars


/* Psceudo url request*/
- (void) getDataFromURL:(NSString*) url
             onSuccess:(void(^)(BOOL successOperation)) success
             onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure;


#pragma mark - Methods for TableView work

- (id) cellViewModel:(NSInteger) index;  // Get cell's viewModel from array

- (NSInteger) countViewModels;           // Count all viewmodels in array

- (void) deleteVMfromCellsArrayByIndexPath:(RXIndexPath*) path; // Delete some row
- (BOOL) canDeleteRowAtRXIndexPath:(RXIndexPath*) indexPath;   // Ask from ViewModel - "Can I delete some row ?"

@end
