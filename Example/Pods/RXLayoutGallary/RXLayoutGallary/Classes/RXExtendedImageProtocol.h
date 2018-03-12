//
//  RXExtendedImageProtocol.h
//  RXLayoutGallary
//
//  Created by Uber on 20/02/2018.
//

#import <Foundation/Foundation.h>

@import UIKit;

@protocol RXExtendedImageProtocol <NSObject>

@property(nonatomic, strong) NSString* url;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* summary;
@property(nonatomic, strong) NSString* credit;

@property (nonatomic, assign) BOOL isGIF;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData  *imageData;

@end

