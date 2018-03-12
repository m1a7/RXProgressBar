//
//  RXExtendedImage.h
//  FLAnimatedImage
//
//  Created by Uber on 19/02/2018.
//

#import <Foundation/Foundation.h>
#import "RXExtendedImageProtocol.h"

@import UIKit;
@interface RXExtendedImage : NSObject <RXExtendedImageProtocol>

/*
 Use wrapper "RXExtendedImage" if you want to add a description to the picture.
 In this format, you can add.
 picture by url
 gif     by url
 UIImage
 NSData
 */

@property (nonatomic, assign) BOOL isGIF;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData  *imageData;
@property (nonatomic, strong) UIImage *placeholderImage;

@property(nonatomic, strong) NSString* url;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* summary;
@property(nonatomic, strong) NSString* credit;

- (instancetype)initWithURL:(NSString*) url andIsGIF:(BOOL) isGIF;
- (instancetype)initWithImage:(UIImage*) image;
- (instancetype)initWithData:(NSData*) dataImage andIsGIF:(BOOL) isGIF;



@end
