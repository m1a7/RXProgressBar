//
//  RXMiddleCellModel.h
//  FBSnapshotTestCase
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCellModel.h"

// Protocols
#import "RXInstructionModelProtocol.h"

@interface RXMiddleCellModel : RXBaseCellModel <RXInstructionModelProtocol>

@property (nonatomic, strong) NSString* instruction;
@property (nonatomic, strong) NSArray<id< RXInstructionImgModelProtocol >>* imagesURL;

@end
