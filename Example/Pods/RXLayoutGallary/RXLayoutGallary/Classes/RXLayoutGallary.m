//
//  RXLayoutGallary.m
//  FBSnapshotTestCase
//
//  Created by Uber on 15/02/2018.
//

#import "RXLayoutGallary.h"
// Another fraemwork
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <FLAnimatedImage/FLAnimatedImage.h>


@interface RXLayoutGallary ()
@end

@implementation RXLayoutGallary

#define offset 5.f
#pragma mark - Designated Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareGallaryProperties];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareGallaryProperties];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id<RXLayoutGallaryDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareGallaryProperties];
        self.delegate = delegate;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withContentModeForImages:(UIViewContentMode) mode andDelegate:(id<RXLayoutGallaryDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareGallaryProperties];
        self.contentMode = mode;
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithContentModeForImages:(UIViewContentMode) mode andDelegate:(id<RXLayoutGallaryDelegate>) delegate
{
    self = [super init];
    if (self) {
        [self prepareGallaryProperties];
        self.contentMode = mode;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark -  Prepare properties for use of the facility

- (void) prepareGallaryProperties {
    self.imagesArray       = [NSMutableArray new];
    self.sourceImagesArray = [NSMutableArray new];
}


- (void) removeAllImageFromGallary
{
    self.delegate = nil;
    [self.imagesArray removeAllObjects];
    [self.sourceImagesArray removeAllObjects];
    
    for (UIView* subView in self.subviews) {
        [subView removeFromSuperview];
    }
}


#pragma mark - Add Images to Gallary by UIImage array

- (BOOL) addUIImagesToGallary:(NSArray<UIImage*>*) arr {
    [self addImagesFromMixArray:arr];
    return YES;
}

#pragma mark - Add Images to Gallary by UIImageView array

- (BOOL) addUIImageViewsToGallary:(NSArray<UIImageView*>*) arr {
    [self addImagesFromMixArray:arr];
    return YES;
}

#pragma mark - Add Images to Gallary by URL array

- (BOOL) addImageFromURL:(NSArray<NSString*>*) urls {
    [self addImagesFromMixArray:urls];
    return YES;
}


- (BOOL) addRXExtendedImages:(NSArray<RXExtendedImage*>*) arr {
    [self addImagesFromMixArray:arr];
    return YES;
}


- (BOOL) addImagesFromMixArray:(NSArray*) mixArray
{
    __weak RXLayoutGallary* bself = self;
    
    NSArray* arrayWithCGRects = [bself getArrWithRectsByCountImages: mixArray.count];
    
    [arrayWithCGRects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSValue* val = (NSValue*)obj;
        CGRect rect = [val CGRectValue];
        
        UIImage* placeHolder = [UIImage imageNamed:@"placeholder"];
        __block id imgView;
        
        // NSData
        // UIImage
        // UIImageView
        // NSString aka URL
        // RXExtendedImage
        // FLAnimatedImageView
        // FLAnimatedImage
        
        id tmpObjFromMixArray = mixArray[idx];
        // RXExamplePhoto
        
        if ([tmpObjFromMixArray conformsToProtocol:@protocol(RXExtendedImageProtocol)])
        {
            id <RXExtendedImageProtocol> convertObj = tmpObjFromMixArray;
            
            RXExtendedImage* exImg = [[RXExtendedImage alloc] init];
            exImg.url     = convertObj.url;
            exImg.title   = convertObj.title;
            exImg.summary = convertObj.summary;
            exImg.credit  = convertObj.credit;
            
            exImg.isGIF             = convertObj.isGIF;
            exImg.image             = convertObj.image;
            exImg.imageData         = convertObj.imageData;
            
            tmpObjFromMixArray = exImg;
        }
        
        // NSString
        if ([tmpObjFromMixArray isKindOfClass:[NSString class]]){
            
            NSString* url = (NSString*)tmpObjFromMixArray;
            
            if ([url rangeOfString:@".gif"].location != NSNotFound) {
                
                imgView = [[FLAnimatedImageView alloc] initWithImage:placeHolder];
                [bself loadAnimatedImageWithURL:[NSURL URLWithString:url] completion:^(FLAnimatedImage *animatedImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [imgView setAnimatedImage:animatedImage];
                    });
                }];
            } else {
                imgView = [bself createUIImageViewByRect:rect andImg:nil];
                [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder];
            }
        }
        // NSData
        if ([tmpObjFromMixArray isKindOfClass:[NSData class]]) {
            
            NSData* data = (NSData*)tmpObjFromMixArray;
            
            FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data];
            imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgView setAnimatedImage:animatedImage1];
            });
        }
        
        // UIImageView
        if ([tmpObjFromMixArray isKindOfClass:[UIImageView class]]){
            
            UIImageView* convertToImgView = (UIImageView*)tmpObjFromMixArray;
            imgView = (UIImageView*)[bself createUIImageViewByRect:rect andImg:convertToImgView.image];
        }
        
        // UIImage
        if ([tmpObjFromMixArray isKindOfClass:[UIImage class]]){
            UIImage* img  = (UIImage*)tmpObjFromMixArray;
            imgView = [bself createUIImageViewByRect:rect andImg:img];
        }
        
        // RXExtendedImage
        if ([tmpObjFromMixArray isKindOfClass:[RXExtendedImage class]]){
            RXExtendedImage* exImg =(RXExtendedImage*)tmpObjFromMixArray;
            
            if (exImg.url.length > 0)
            {
                if ([exImg.url rangeOfString:@".gif"].location != NSNotFound) {
                    
                    imgView = [[FLAnimatedImageView alloc] initWithImage:placeHolder];
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                    dispatch_async(queue, ^{
                        
                        [bself loadAnimatedImageWithURL:[NSURL URLWithString:exImg.url] completion:^(FLAnimatedImage *animatedImage) {
                            exImg.imageData = animatedImage.data;
                            exImg.isGIF     = YES;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [imgView setAnimatedImage:animatedImage];
                            });
                        }];
                    });
                } else {
                    imgView = [bself createUIImageViewByRect:rect andImg:nil];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:exImg.url] placeholderImage:placeHolder];
                }
            }else if (exImg.imageData && exImg.isGIF)
            {
                FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:exImg.imageData];
                imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imgView setAnimatedImage:animatedImage1];
                });
            }
            if (exImg.imageData && !exImg.isGIF)
            {
                imgView = [bself createUIImageViewByRect:rect andImg:[UIImage imageWithData:exImg.imageData]];
            }
            
            if (exImg.image)
            {
                imgView = [bself createUIImageViewByRect:rect andImg:exImg.image];
            }
        }
        // FLAnimatedImageView
        if ([tmpObjFromMixArray isMemberOfClass:[FLAnimatedImageView class]])
        {
            imgView = tmpObjFromMixArray;
            [imgView setFrame:rect];
        }
        
        // FLAnimatedImage
        if ([tmpObjFromMixArray isMemberOfClass:[FLAnimatedImage class]])
        {
            imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgView setAnimatedImage:tmpObjFromMixArray];
            });
        }
        
        if (imgView){
            [imgView setTag:idx];
            [bself.imagesArray       addObject:imgView];
            [bself.sourceImagesArray addObject:tmpObjFromMixArray];
            [bself setupUIImageView:imgView];
            [bself addSubview:imgView];
        }
        
    }];
    return YES;
}


- (void) removeImageByIndex:(NSInteger) index
{
    for (id subView in self.subviews) {
        
        UIView* convertView =  (UIView*)subView;
        if (convertView.tag == index){
            [self.sourceImagesArray removeObjectAtIndex:index];
            [convertView removeFromSuperview];
            [self.imagesArray removeObjectAtIndex:index];
        }
    }
}

- (id) getSubviewFromGallaryByIndex:(NSInteger)index
{
    for (id subView in self.subviews) {
        UIView* convertView =  (UIView*)subView;
        if (convertView.tag == index){
            return subView;
        }
    }
    return nil;
}


#pragma mark - Get array with  correct frame

- (NSArray*) getArrWithRectsByCountImages:(NSInteger) count
{
    switch (count) {
        case 1: return  [self getRectArrForOnePic];    break;
        case 2: return  [self getRectArrForTwoPics];   break;
        case 3: return  [self getRectArrForThreePics]; break;
        case 4: return  [self getRectArrForFourPics];  break;
        case 5: return  [self getRectArrForFivePics];  break;
        default:
            break;
    }
    if (count > 5)
        return [self getRectArrForFivePics];
    
    return nil;
}

#pragma mark - Create UIImageView

- (UIImageView*) createUIImageViewByRect:(CGRect) frame andImg:(UIImage*) img
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = img;
    [self setupUIImageView:imgView];
    return imgView;
}

#pragma mark - Resize all subviews

-(void) layoutSubviews{
    [super layoutSubviews];
    [self resizeSubview];
}

-(void) resizeSubview{
    
    __weak RXLayoutGallary* bself = self;
    
    NSArray* newSizes = [self getArrWithRectsByCountImages: self.subviews.count];
    [newSizes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSValue* val = (NSValue*)obj;
        CGRect rect = [val CGRectValue];
        bself.subviews[idx].frame = rect;
    }];
}


#pragma mark - Setup UIImageView

- (void) setupUIImageView:(UIImageView*) imgView
{
    imgView.clipsToBounds = YES;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (imgView.image.size.height > imgView.image.size.width){
        imgView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    if (self.imagesContentMode){
        imgView.contentMode = self.imagesContentMode;
    }
    
    if ([_delegate respondsToSelector:@selector(rxgallaryView:didTapAtImageView:sourceObject:atIndex:)]) {
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecogmiserDidFire:)];
        imgView.gestureRecognizers = @[ rec ];
    }
    
}

#pragma mark - Action
- (IBAction)tapGestureRecogmiserDidFire:(UITapGestureRecognizer *)sender {
    
    if ([_delegate respondsToSelector:@selector(rxgallaryView:didTapAtImageView:sourceObject:atIndex:)])
        [_delegate rxgallaryView:self didTapAtImageView:(UIImageView *)sender.view sourceObject:self.sourceImagesArray[sender.view.tag] atIndex:sender.view.tag];
}


#pragma mark -  NSArray with CGRect => NSValues

-(NSArray*) getRectArrForOnePic
{
    return @[ [NSValue valueWithCGRect: CGRectMake(offset,
                                                   offset,
                                                   CGRectGetWidth(self.frame)-offset*2,
                                                   CGRectGetHeight(self.frame)-offset*2)]
              ];
}

-(NSArray*) getRectArrForTwoPics
{
    CGRect firstRect   = CGRectMake(offset,
                                    offset,
                                    (CGRectGetWidth(self.frame)/2)-offset*2,
                                    CGRectGetHeight(self.frame)-offset*2);
    
    CGRect secondRect  = CGRectMake(CGRectGetMaxX(firstRect)+offset,
                                    offset,
                                    (CGRectGetWidth(self.frame)/2)-offset*2,
                                    CGRectGetHeight(self.frame)-offset*2);
    
    return @[ [NSValue valueWithCGRect: firstRect],
              [NSValue valueWithCGRect: secondRect]
              ];
}

-(NSArray*) getRectArrForThreePics
{
    CGRect firstRect = CGRectMake(offset,
                                  offset,
                                  (CGRectGetWidth(self.frame)/2)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*60) - offset*2);
    
    CGRect secondRect = CGRectMake(CGRectGetMaxX(firstRect)+offset,
                                   offset,
                                   (CGRectGetWidth(self.frame)/2)-offset,
                                   ((CGRectGetHeight(self.frame)/100)*60) - offset*2);
    
    CGRect thridRect = CGRectMake(offset,
                                  CGRectGetMaxY(firstRect)+offset,
                                  CGRectGetWidth(self.frame)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*40) - offset*2);
    
    return @[ [NSValue valueWithCGRect: firstRect],
              [NSValue valueWithCGRect: secondRect],
              [NSValue valueWithCGRect: thridRect]
              ];
}

-(NSArray*) getRectArrForFourPics
{
    CGRect firstRect = CGRectMake(offset,
                                  offset,
                                  (CGRectGetWidth(self.frame)/2)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*50) - offset*2);
    
    CGRect secondRect = CGRectMake(CGRectGetMaxX(firstRect)+offset,
                                   offset,
                                   (CGRectGetWidth(self.frame)/2)-offset,
                                   ((CGRectGetHeight(self.frame)/100)*50) - offset*2);
    
    CGRect thridRect = CGRectMake(offset,
                                  CGRectGetMaxY(firstRect)+offset,
                                  (CGRectGetWidth(self.frame)/2)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*50) - offset*2);
    
    CGRect fourthRect = CGRectMake(CGRectGetMaxX(firstRect)+offset,
                                   CGRectGetMaxY(firstRect)+offset,
                                   (CGRectGetWidth(self.frame)/2)-offset,
                                   ((CGRectGetHeight(self.frame)/100)*50) - offset*2);
    
    return @[ [NSValue valueWithCGRect: firstRect],
              [NSValue valueWithCGRect: secondRect],
              [NSValue valueWithCGRect: thridRect],
              [NSValue valueWithCGRect: fourthRect]
              ];
}

-(NSArray*) getRectArrForFivePics
{
    CGRect firstRect = CGRectMake(offset,
                                  offset,
                                  (CGRectGetWidth(self.frame)/2)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*70) - offset*2);
    
    CGRect secondRect = CGRectMake(CGRectGetMaxX(firstRect)+offset,
                                   offset,
                                   (CGRectGetWidth(self.frame)/2)-offset,
                                   ((CGRectGetHeight(self.frame)/100)*70) - offset*2);
    
    CGRect thridRect = CGRectMake(offset,
                                  CGRectGetMaxY(firstRect)+offset,
                                  (CGRectGetWidth(self.frame)/3)-offset*2,
                                  ((CGRectGetHeight(self.frame)/100)*30) - offset*2);
    
    CGRect fourthRect = CGRectMake(CGRectGetMaxX(thridRect)+offset,
                                   CGRectGetMaxY(firstRect)+offset,
                                   (CGRectGetWidth(self.frame)/3)-offset,
                                   ((CGRectGetHeight(self.frame)/100)*30) - offset*2);
    
    CGRect fifthRect = CGRectMake(CGRectGetMaxX(fourthRect)+offset,
                                  CGRectGetMaxY(firstRect)+offset,
                                  (CGRectGetWidth(self.frame)/3)-offset,
                                  ((CGRectGetHeight(self.frame)/100)*30) - offset*2);
    
    return @[ [NSValue valueWithCGRect: firstRect],
              [NSValue valueWithCGRect: secondRect],
              [NSValue valueWithCGRect: thridRect],
              [NSValue valueWithCGRect: fourthRect],
              [NSValue valueWithCGRect: fifthRect]
              ];
}

#pragma mark - Helpers method download GIF image from url

- (void)loadAnimatedImageWithURL:(NSURL*)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    __weak RXLayoutGallary* bself = self;
    
    NSBlockOperation *downloadOperation = [NSBlockOperation new];
    [downloadOperation addExecutionBlock:^{
        
        NSData *imgFromCache;
        if ([bself.delegate respondsToSelector:@selector(getDataFromCacheByURL:)]) {
            imgFromCache = [bself.delegate getDataFromCacheByURL:url.absoluteString];
        }
        if (imgFromCache) {
            FLAnimatedImage*  animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:imgFromCache];
            completion(animatedImage);
        }
        else {
            NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                           downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                               
                                                               NSData* data=  [NSData dataWithContentsOfURL:url];
                                                               if (data) {
                                                                   if ([bself.delegate respondsToSelector:@selector(writeToCacheData:urlKey:)]) {
                                                                       [bself.delegate writeToCacheData:data urlKey:url.absoluteString];
                                                                   }
                                                               }
                                                               FLAnimatedImage* animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
                                                               completion(animatedImage);
                                                           }];
            [downloadPhotoTask resume];
            if ([bself.delegate respondsToSelector:@selector(addURLSessionDownTaskToArray:)]){
                [bself.delegate addURLSessionDownTaskToArray:downloadPhotoTask];
            }
        }
    }];
    
    [downloadOperation main];
    NSOperationQueue *downloadingQueue;
    
    if ([bself.delegate respondsToSelector:@selector(getOperationQueue)])
        downloadingQueue = [bself.delegate getOperationQueue];
    else
        downloadingQueue = [NSOperationQueue mainQueue];
    
    [downloadingQueue addOperation:downloadOperation];
}

- (void) dealloc {
    for (NSURLSessionDownloadTask* task in [self.delegate arrayURLSessionTask]){
        [task suspend];
        [task cancel];
    }
    [self.delegate cancelAllRequest];
    [self removeAllImageFromGallary];
}


@end

