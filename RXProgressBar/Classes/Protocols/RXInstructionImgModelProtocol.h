//
//  RXInstructionImgModelProtocol.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>
#import <RXLayoutGallary/RXExtendedImageProtocol.h>

/*
протокол RXInstructionImgModelProtocol.
Это протокол нужен для того, что бы была возможность поддержки подписи (title/summary/сredit)
под фотографией. Подпись будет видна при открытии фотографии на полный экран с помощью фраемворка NYPhotoViewer.
 
 В свою очередь RXInstructionImgModelProtocol, поддерживает протокол RXExtendedImageProtocol фраемворка RXLayoutGallary.
 
*/
@protocol RXInstructionImgModelProtocol <RXExtendedImageProtocol>

@property(nonatomic, strong) NSString* url;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* summary;
@property(nonatomic, strong) NSString* credit;

@property (nonatomic, assign) BOOL isGIF;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData  *imageData;

@end
