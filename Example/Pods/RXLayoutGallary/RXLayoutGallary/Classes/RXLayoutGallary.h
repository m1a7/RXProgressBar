//
//  RXLayoutGallary.h
//  FBSnapshotTestCase
//
//  Created by Uber on 15/02/2018.
//

#import <UIKit/UIKit.h>
#import "RXExtendedImage.h"

@class RXLayoutGallary;

@protocol RXLayoutGallaryDelegate <NSObject>

@optional

- (void)rxgallaryView:(RXLayoutGallary *)rxlayoutGallary didTapAtImageView:(UIImageView *)imageView sourceObject:(id) sourceImage atIndex:(NSUInteger)index;

/*
 Need for optimization download image to gallary from tableView
 */

- (void)     addURLSessionDownTaskToArray:(NSURLSessionDownloadTask*) downloadTask;
- (NSArray*) arrayURLSessionTask;
- (void)     cancelAllRequest;


- (NSData*) getDataFromCacheByURL:(NSString*) urlStr;
- (void)    writeToCacheData:(NSData*) data urlKey:(NSString*) key;
- (NSOperationQueue*) getOperationQueue;

@end

@interface RXLayoutGallary : UIView

- (BOOL) addUIImagesToGallary:(NSArray<UIImage*>*) arr;
- (BOOL) addUIImageViewsToGallary:(NSArray<UIImageView*>*) arr;
- (BOOL) addImageFromURL:(NSArray<NSString*>*) urls;
- (BOOL) addRXExtendedImages:(NSArray<RXExtendedImage*>*) arr;
- (BOOL) addImagesFromMixArray:(NSArray*) mixArray;


- (id) getSubviewFromGallaryByIndex:(NSInteger)index;

- (void) removeImageByIndex:(NSInteger) index;
- (void) removeAllImageFromGallary;

@property (nonatomic, weak)   id <RXLayoutGallaryDelegate> delegate;
@property (nonatomic, strong) NSMutableArray<UIImageView*> *imagesArray;
@property (nonatomic, strong) NSMutableArray               *sourceImagesArray;

@property (nonatomic, assign) UIViewContentMode imagesContentMode;

#pragma mark - Designated Initializers

- (instancetype)init;

// (Designated Initializer)   Frame  + Delegate
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id<RXLayoutGallaryDelegate>) delegate;

// (Designated Initializer)   ContentMode + Delegate
- (instancetype)initWithContentModeForImages:(UIViewContentMode) mode andDelegate:(id<RXLayoutGallaryDelegate>) delegate;

// (Designated Initializer)   Frame + ContentMode + Delegate
- (instancetype)initWithFrame:(CGRect)frame withContentModeForImages:(UIViewContentMode) mode andDelegate:(id<RXLayoutGallaryDelegate>) delegate;

@end

