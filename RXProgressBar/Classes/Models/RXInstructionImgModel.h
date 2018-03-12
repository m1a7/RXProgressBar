//
//  RXInstructionImgModel.h
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import <Foundation/Foundation.h>

// Protocol
#import "RXInstructionImgModelProtocol.h"

@interface RXInstructionImgModel : NSObject <RXInstructionImgModelProtocol>

@property(nonatomic, strong) NSString* url;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* summary;
@property(nonatomic, strong) NSString* credit;

@property (nonatomic, assign) BOOL isGIF;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData  *imageData;

- (instancetype)initWithURL:(NSString*) url andTitle:(NSString*) title;

@end
