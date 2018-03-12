//
//  RXWrapperNYTPhoto.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>
#import <NYTPhotoViewer/NYTPhoto.h>

/*
 Объект обложка над NYTPhoto, нужна чтобы
 в ячейки RXMiddleCell при нажатии на фото,
 сформировать массив фото которые отвечают протоколу NYTPhoto.
 
 Собственно создаем этот объект и настраиваем его.

*/
@interface RXWrapperNYTPhoto : NSObject <NYTPhoto>

// Redeclare all the properties as readwrite for sample/testing purposes.
@property (nonatomic) UIImage *image;
@property (nonatomic) NSData *imageData;
@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) NSAttributedString *attributedCaptionTitle;
@property (nonatomic) NSAttributedString *attributedCaptionSummary;
@property (nonatomic) NSAttributedString *attributedCaptionCredit;

@end
