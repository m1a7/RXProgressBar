//
//  DataBuilder.h
//  RXProgressBar_Example
//
//  Created by Uber on 10/03/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import <Foundation/Foundation.h>

// Protocols
#import <RXProgressBar/RXInstructionModelProtocol.h>


@interface DataBuilder : NSObject


+ (NSArray<id<RXInstructionModelProtocol>>*) createPumkinInstruction;

+ (NSArray<id<RXInstructionModelProtocol>>*) createTomAndJerryInstruction;

@end
