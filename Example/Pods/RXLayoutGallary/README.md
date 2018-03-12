# RXLayoutGallary

[![CI Status](http://img.shields.io/travis/m1a7/RXLayoutGallary.svg?style=flat)](https://travis-ci.org/m1a7/RXLayoutGallary)
[![Version](https://img.shields.io/cocoapods/v/RXLayoutGallary.svg?style=flat)](http://cocoapods.org/pods/RXLayoutGallary)
[![License](https://img.shields.io/cocoapods/l/RXLayoutGallary.svg?style=flat)](http://cocoapods.org/pods/RXLayoutGallary)
[![Platform](https://img.shields.io/cocoapods/p/RXLayoutGallary.svg?style=flat)](http://cocoapods.org/pods/RXLayoutGallary)

## Start

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation
It works with iOS 8.0 and newer.
RXLayoutGallary is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RXLayoutGallary', :git => 'https://github.com/m1a7/RXLayoutGallary.git'
```

# RXLayoutGallary
RXLayoutGallary - This is Objective-C version fraemwork. Using the library you can add from one up to five photos.
These photos will be posted of the beautiful grid.

| iPhone Vertical   |
| ------------|
|![alt text](https://raw.githubusercontent.com/m1a7/RXLayoutGallary/master/Screens/iphoneScreen.gif)  |

<br>

| iPad Vertical & Horizontal  |
| ------------- |
|![alt text](https://raw.githubusercontent.com/m1a7/RXLayoutGallary/master/Screens/ipadScreen.gif) |




### Introduction

#### Step 1.
Make import.
```objective-c
#import <RXLayoutGallary/RXLayoutGallary.h>
```

#### Step 2.
 Conform to protocols.
```objective-c
@interface RXViewController () <RXLayoutGallaryDelegate, NYTPhotosViewControllerDelegate, NYTPhotoViewerDataSource>
...
@end
```


#### Step 3.
Add these properties . They are needed for the correct operation of the framework, which opens photos in full screen mode.
```objective-c
@interface RXViewController () <RXLayoutGallaryDelegate, NYTPhotosViewControllerDelegate, NYTPhotoViewerDataSource>

@property (nonatomic, strong) NSMutableArray *imageForNYTPhotosVC;
@property (nonatomic, strong) NSNumber *numberOfPhotos;
@property (nonatomic, strong) UIImageView *touchedImgView;

@end
```

#### Step 4.
Initialize and add to superview the RXLayoutGallary is comfortable for you path.
You have 3 option's.

1. Pass to RXLayoutGallary array with URLs
2. Pass to RXLayoutGallary array with UIImage or NSData (*nsdata only for gif images )
3. Pass to RXLayoutGallary array with UIImageView

```objective-c
// Init
RXLayoutGallary* gallaryURL = [[RXLayoutGallary alloc] initWithFrame:self.viewForURLGallary.bounds
andDelegate:self];

// Add to some superview
[self.viewForURLGallary addSubview:gallaryURL];
```

```objective-c
// Add pictures - Path by URL array
[gallaryURL addImageFromURL: self.urlImages];
```

OR
```objective-c
// Add pictures - Path by UIImage array
[gallaryLocalImages addUIImagesToGallary:self.localImages];
```
OR
```objective-c
// Add pictures - Path by UIImageViews array
[gallaryURL addUIImageViewsToGallary: self.localImages];
```


#### Step 5.
Implement the delegate <GallaryViewDelegate> method.


```objective-c
#pragma mark - GallaryViewDelegate

-(void)rxgallaryView:(RXLayoutGallary *)rxlayoutGallary didTapAtImageView:(UIImageView *)imageView atIndex:(NSUInteger)index{

    self.imageForNYTPhotosVC = [NSMutableArray new];;
    self.numberOfPhotos      = [NSNumber numberWithInteger:rxlayoutGallary.imagesArray.count];
    self.touchedImgView      = imageView;


    for (id imgFromGallary in rxlayoutGallary.imagesArray) {

        RXExamplePhoto *p = [RXExamplePhoto new];
        p.attributedCaptionTitle  = [RXViewController attributedTitleFromString:@"Chess"];
        p.attributedCaptionCredit = [RXViewController attributedCreditFromString:@"Photo: Chris Dzombak"];

        if ([imgFromGallary isMemberOfClass:[UIImageView class]])
        {
            UIImageView* imgView = (UIImageView*)imgFromGallary;
            [self.imageForNYTPhotosVC addObject:({
                p.image = imgView.image;
                p;
            })];
        }
        if ([imgFromGallary isMemberOfClass:[FLAnimatedImageView class]])
        {
            FLAnimatedImageView* flaImgView = (FLAnimatedImageView*)imgFromGallary;
            [self.imageForNYTPhotosVC addObject:({
                p.imageData = flaImgView.animatedImage.data;
                p;
            })];
        }
    }
    NYTPhotosViewController* vc = [[NYTPhotosViewController alloc] initWithDataSource:self
                                                                    initialPhotoIndex:index
                                                                             delegate:self];

    [self presentViewController:vc animated:YES completion:nil];
}
```
If you want, you can conform methods:
They are need for most productive work with TableView.
You should store in your controller or viewmodel cache property, then images will until upload from local cache.

```objective-c
-(NSData*) getDataFromCacheByURL:(NSString*) urlStr;
-(void) writeToCacheData:(NSData*) data urlKey:(NSString*) key;
-(NSOperationQueue*) getOperationQueue;
```

#### Step 6.
Implement the delegate <NYTPhotoViewerDataSource> methods.

```objective-c
#pragma mark - NYTPhotoViewerDataSource

- (NSInteger)indexOfPhoto:(id <NYTPhoto>)photo {
    return [self.imageForNYTPhotosVC indexOfObject:photo];
}

- (nullable id <NYTPhoto>)photoAtIndex:(NSInteger)photoIndex
{
    if (self.imageForNYTPhotosVC.count > photoIndex){
        return [self.imageForNYTPhotosVC objectAtIndex:photoIndex];
    }
    return  nil;
}
```

#### Step 7. - Optional
Implement the delegate <NYTPhotosViewControllerDelegate> and helpers methods .


```objective-c
#pragma mark - NYTPhotosViewControllerDelegate

- (UIView *)photosViewController:(NYTPhotosViewController *)photosViewController referenceViewForPhoto:(id <NYTPhoto>)photo {
    return self.touchedImgView;
}

#pragma mark - Helpers

+ (NSAttributedString *)attributedTitleFromString:(NSString *)caption {
    return [[NSAttributedString alloc] initWithString:caption
                                            attributes: @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                        NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}
+ (NSAttributedString *)attributedSummaryFromString:(NSString *)summary {
        return [[NSAttributedString alloc] initWithString:summary
                                               attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}

+ (NSAttributedString *)attributedCreditFromString:(NSString *)credit {
        return [[NSAttributedString alloc] initWithString:credit
                                               attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                               NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]}];
}

```
#### Profit !!!!


## Author

m1a7, thisismymail03@gmail.com

## License

RXLayoutGallary is available under the MIT license. See the LICENSE file for more info.
