//
//  RXInstructionModel.h
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import <Foundation/Foundation.h>

#import "RXInstructionModelProtocol.h"

@interface RXInstructionModel : NSObject <RXInstructionModelProtocol>

@property (nonatomic, strong) NSString* instruction;
@property (nonatomic, strong) NSArray<id< RXInstructionImgModelProtocol >>* imagesURL;

- (instancetype)initWithInstruction:(NSString*) instruction
                        withImgsURL:(NSArray<id<RXInstructionImgModelProtocol>>*)imgArr;

- (instancetype)initWithInstruction:(NSString*) instruction
                     withMixArrImgs:(NSArray*)imgArr;

@end
