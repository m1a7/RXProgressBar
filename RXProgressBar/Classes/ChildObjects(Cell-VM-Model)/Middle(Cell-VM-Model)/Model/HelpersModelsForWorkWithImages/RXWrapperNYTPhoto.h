//
//  RXWrapperNYTPhoto.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

#import <NYTPhotoViewer/NYTPhoto.h>

/*
 Object cover over NYTPhoto, needed to
 in rxmiddlecell cells when you click on a photo,
 create an array of photos that meet the Protocol NYTPhoto.
 Actually create this object and configure it.
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
