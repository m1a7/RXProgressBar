//
//  RXExtendedImage.m
//  FLAnimatedImage
//
//  Created by Uber on 19/02/2018.
//

#import "RXExtendedImage.h"

@implementation RXExtendedImage

- (instancetype)initWithURL:(NSString*) url andIsGIF:(BOOL) isGIF
{
    self = [super init];
    if (self) {
        self.url  = url;
        self.isGIF = isGIF;

    }
    return self;
}
- (instancetype)initWithImage:(UIImage*) image
{
    self = [super init];
    if (self) {
        self.image  = image;
    }
    return self;
}

- (instancetype)initWithData:(NSData*) dataImage andIsGIF:(BOOL) isGIF
{
    self = [super init];
    if (self) {
        self.imageData  = dataImage;
        self.isGIF  = isGIF;
    }
    return self;
}

@end
