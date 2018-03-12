//
//  RXMiddleCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXMiddleCell.h"

#import "RXWrapperNYTPhoto.h"
#import <FLAnimatedImage/FLAnimatedImage.h>

#define offset 15.f

@interface RXMiddleCell () <NYTPhotosViewControllerDelegate, NYTPhotoViewerDataSource>

// Private properties for NYTPhotoViewer
@property(strong, nonatomic) NSMutableArray<RXWrapperNYTPhoto*>* imageForNYTPhotosVC;
@property(strong, nonatomic) NSNumber *numberOfPhotos;
@property(strong, nonatomic) UIImageView *touchedImgView;

@end



@implementation RXMiddleCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // [self initUIComponents];
    }
    return self;
}

#pragma mark - Setter
- (void) setVm_cell:(RXMiddleViewModelCell *)vm_cell{
    _vm_cell = vm_cell;
    [self setDataToCell];
}

- (void) setDataToCell {
    __weak RXMiddleCell* bself = self;
    CGFloat width =CGRectGetWidth(bself.contentView.frame);
    [bself setInNilAllComponent];
    [bself initUIComponentsWithVM:bself.vm_cell];
    
    
    if (bself.vm_cell.model_cell.instruction.length > 0)
    {
        if (bself.vm_cell.height_InstructionLabel <= 0)
        {
#warning Пофиксить ширифт их UIConfig
            bself.vm_cell.height_InstructionLabel =  [RXMiddleCell heigtForCellwithString: _vm_cell.model_cell.instruction
                                                                                 withFont: [UIFont fontWithName:@"Arial" size:12.0f]
                                                                           withWidthLabel: ((width/100)*95)-offset*2].height;
        }
        [bself setDataToInstructionLabel];
    }
    
    if (bself.vm_cell.model_cell.imagesURL.count > 0)
    {
        if (bself.vm_cell.height_PhotoGallary <= 0)
        {
            bself.vm_cell.height_PhotoGallary = [RXMiddleCell rectForPhotoGallary:CGRectMake(0, 0, width, 0)
                                                           heightInstructionLabel: bself.vm_cell.height_InstructionLabel].size.height;
        }
        [bself setDataToPhotoGallary];
    }
    
    if (self.vm_cell.actualCalculationsForWidth == width)
    {
        [self setFramesSettingFromVMtoSubviews];
    }
}


#pragma mark - Calculate Height

+ (CGFloat) calculateHeightByUIConfig:(NSObject*) conf withVM:(RXMiddleViewModelCell*) vm withWidthView:(CGFloat)width
{
    if ((vm.model_cell.instruction.length <= 0 && vm.model_cell.imagesURL.count <= 0)
        ||
        (!vm.model_cell.instruction && !vm.model_cell.imagesURL))
    {
        return 40.f;
    }
    
    if (vm.model_cell.instruction.length > 0)
    {
        if (vm.height_InstructionLabel <= 0 || vm.actualCalculationsForWidth != width)
        {
#warning Пофиксить ширифт их UIConfig
            vm.height_InstructionLabel = [RXMiddleCell heigtForCellwithString: vm.model_cell.instruction
                                                                     withFont: [UIFont fontWithName:@"Arial" size:12.0f]
                                                               withWidthLabel:  ((width/100)*95)-offset*2].height;
        }
    }
    
    if (vm.model_cell.imagesURL.count > 0)
    {
        if (vm.height_PhotoGallary <= 0 || vm.actualCalculationsForWidth != width)
        {
            vm.height_PhotoGallary      =  [RXMiddleCell rectForPhotoGallary:CGRectMake(0, 0, width, 0)
                                                      heightInstructionLabel:vm.height_InstructionLabel].size.height;
        }
    }
    return [vm getTotalHeightWithOffset:offset];
}



#pragma mark - Init and Add to self.contentView UIComponents
- (void) initUIComponentsWithVM:(RXMiddleViewModelCell*)vm
{
    self.contentView.backgroundColor = [UIColor greenColor];
    if (vm.model_cell.instruction.length > 0)
    {
        self.instructionLabel           = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
        [self setupInstructionLabel];
        [self.contentView addSubview:self.instructionLabel];
    }
    // Тут нужно  делать проверку, если есть в массиве объекты то добавляем
    if (vm.model_cell.imagesURL.count > 0)
    {
        self.photoGallary        = [[RXLayoutGallary alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andDelegate:self];
        [self setupPhotoGallary];
        [self.contentView addSubview:self.photoGallary];
    }
}

+(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font withWidthLabel:(CGFloat)width{
    CGSize constraint = CGSizeMake( roundf(width),9999);
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return CGSizeMake(roundf(rect.size.width), roundf(rect.size.height));
}

-(void) layoutSubviews{
    [super layoutSubviews];
    [self resizeSubviews];
}


- (void) setInNilAllComponent
{
    for (UIView* subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.instructionLabel = nil;
    self.photoGallary = nil;
}


- (void) reloadTabelView
{
    UITableView *parentTable = (UITableView *)self.superview;
    if (![parentTable isKindOfClass:[UITableView class]]) {
        parentTable = (UITableView *) parentTable.superview;
    }
    [parentTable reloadData];
}

- (void) setFramesSettingFromVMtoSubviews
{
    self.instructionLabel.frame = CGRectMake(_vm_cell.x_InstructionLabel,
                                             _vm_cell.y_InstructionLabel,
                                             _vm_cell.width_InstructionLabel,
                                             _vm_cell.height_InstructionLabel);
    self.photoGallary.frame     =  CGRectMake(_vm_cell.x_PhotoGallary,
                                              _vm_cell.y_PhotoGallary,
                                              _vm_cell.width_PhotoGallary,
                                              _vm_cell.height_PhotoGallary);
}

- (void) resizeSubviews
{
    if ( self.vm_cell.actualCalculationsForWidth != self.contentView.frame.size.width)
    {
        if (self.vm_cell.model_cell.instruction.length > 0)
        {
            self.instructionLabel.frame = [self rectForInstructionLabel:self.contentView.frame];
            _vm_cell.x_InstructionLabel      = self.instructionLabel.frame.origin.x;
            _vm_cell.y_InstructionLabel      = self.instructionLabel.frame.origin.y;
            _vm_cell.width_InstructionLabel  = self.instructionLabel.frame.size.width;
            _vm_cell.height_InstructionLabel = self.instructionLabel.frame.size.height;
        }
        if (self.vm_cell.model_cell.imagesURL.count > 0)
        {
            self.photoGallary.frame     = [RXMiddleCell rectForPhotoGallary:self.contentView.frame
                                                     heightInstructionLabel:CGRectGetHeight(self.instructionLabel.frame)];
            _vm_cell.x_PhotoGallary      = self.photoGallary.frame.origin.x;
            _vm_cell.y_PhotoGallary      = self.photoGallary.frame.origin.y;
            _vm_cell.width_PhotoGallary  = self.photoGallary.frame.size.width;
            _vm_cell.height_PhotoGallary = self.photoGallary.frame.size.height;
        }
        self.vm_cell.actualCalculationsForWidth = CGRectGetWidth(self.contentView.frame);
    }
}



#pragma mark - RXLayoutGallaryDelegate

-(void) rxgallaryView:(RXLayoutGallary *)rxlayoutGallary didTapAtImageView:(UIImageView *)imageView sourceObject:(id)sourceImage atIndex:(NSUInteger)index
{
    self.imageForNYTPhotosVC = [NSMutableArray new];;
    self.numberOfPhotos      = [NSNumber numberWithInteger:rxlayoutGallary.imagesArray.count];
    self.touchedImgView      = imageView;
    
    [rxlayoutGallary.imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull imgFromGallary, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RXWrapperNYTPhoto *p = [RXWrapperNYTPhoto new];
        
        //Ask if in our second array source Images Array the object RX Extended Image
        // If so, set RXExamplePhoto text properti
        if ([[rxlayoutGallary.sourceImagesArray objectAtIndex:idx] isKindOfClass:[RXExtendedImage class]])
        {
            RXExtendedImage* exImgView = (RXExtendedImage*)[rxlayoutGallary.sourceImagesArray objectAtIndex:idx];
            
            if (exImgView.title)    p.attributedCaptionTitle   =  [RXMiddleCell attributedTitleFromString:exImgView.title];
            if (exImgView.summary)  p.attributedCaptionSummary =  [RXMiddleCell attributedSummaryFromString:exImgView.summary];
            if (exImgView.credit)   p.attributedCaptionCredit  =  [RXMiddleCell attributedCreditFromString:exImgView.credit];
            
        }
        // And further everything as according to the plan, we ask if in our main array images Array
        // Lies the FLAnimatedImageView object, then such actions
        if ([imgFromGallary isKindOfClass:[FLAnimatedImageView class]])
        {
            FLAnimatedImageView* flaImgView = (FLAnimatedImageView*)imgFromGallary;
            [self.imageForNYTPhotosVC addObject:({
                p.imageData = flaImgView.animatedImage.data;
                p;
            })];
        } else
            // If the UIImageView object is Lying, then such actions
            if ([imgFromGallary isKindOfClass:[UIImageView class]])
            {
                UIImageView* imageView = (UIImageView*)imgFromGallary;
                [self.imageForNYTPhotosVC addObject:({
                    p.image = imageView.image;
                    p;
                })];
            }
        // And it could only lie UIImageView or FLAnimatedImageView
    }];
    
    NYTPhotosViewController* vc = [[NYTPhotosViewController alloc] initWithDataSource:self
                                                                    initialPhotoIndex:index
                                                                             delegate:self];
    UIViewController* activeVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [activeVC presentViewController:vc
                           animated:YES
                         completion:NULL];
}

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

#pragma mark - NYTPhotosViewControllerDelegate

- (UIView *)photosViewController:(NYTPhotosViewController *)photosViewController referenceViewForPhoto:(id <NYTPhoto>)photo {
    return self.touchedImgView;
}
+ (NSAttributedString *)attributedTitleFromString:(NSString *)caption {
    return [[NSAttributedString alloc] initWithString:caption attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}

+ (NSAttributedString *)attributedSummaryFromString:(NSString *)summary {
    return [[NSAttributedString alloc] initWithString:summary attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}

+ (NSAttributedString *)attributedCreditFromString:(NSString *)credit {
    return [[NSAttributedString alloc] initWithString:credit attributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]}];
}


#pragma mark - Get CGRect Configuration for UIControl(s)

- (CGRect) rectForInstructionLabel:(CGRect) superViewFrame
{
    CGFloat height =  (self.vm_cell.height_InstructionLabel) ? _vm_cell.height_InstructionLabel : 40.f;
    CGFloat weight =  ((CGRectGetWidth(superViewFrame)/100)*95)-offset*2;
    CGFloat x      =  ((CGRectGetWidth(superViewFrame)/100)*5)+offset;
    CGFloat y      =  offset;
    CGRect rect = CGRectMake(roundf(x), roundf(y), roundf(weight), roundf(height));
    return rect;
}


+ (CGRect) rectForPhotoGallary:(CGRect) superViewFrame heightInstructionLabel:(CGFloat) heightInstruction
{
    CGFloat weight = ((CGRectGetWidth(superViewFrame)/100)*95)-offset*2;
    CGFloat height = roundf(weight/2);
    CGFloat x      = ((CGRectGetWidth(superViewFrame)/100)*5)+offset;
    CGFloat y = 0;
    if (heightInstruction>0)
        y = offset+heightInstruction+offset;
    else
        y = offset;
    
    CGRect  rect   = CGRectMake(roundf(x), roundf(y), roundf(weight), roundf(height));
    return rect;
}

#pragma mark - Setup UI Components

- (void) setupInstructionLabel
{
    if (self.instructionLabel){
        self.instructionLabel.numberOfLines   = 0;
        self.instructionLabel.textColor       = [UIColor blackColor];
#warning fix шрифт из uiconfig
        self.instructionLabel.font            = [UIFont fontWithName:@"Arial" size:12.0f];
        self.instructionLabel.backgroundColor = [UIColor blueColor];
    } else {
        NSLog(@"Attempt to initialize component which is equal nil : instructionLabel");
    }
}

- (void) setupPhotoGallary
{
    if (self.photoGallary){
        self.photoGallary.backgroundColor = [UIColor yellowColor];
    } else {
        NSLog(@"Attempt to initialize component which is equal nil : photoGallary");
    }
}

#pragma mark - Set data to UI Components

-(void) setDataToInstructionLabel
{
    if (self.instructionLabel && self.vm_cell.model_cell.instruction){
        self.instructionLabel.text = self.vm_cell.model_cell.instruction;
    } else {
        NSLog(@"Attempt to set data. component which is equal nil : self.instructionLabel");
    }
}

-(void) setDataToPhotoGallary
{
    if (self.photoGallary && self.vm_cell.model_cell.imagesURL.count > 0){
        //[self.photoGallary addImageFromURL: self.vm_cell.model_cell.imagesURL];
        [self.photoGallary addImagesFromMixArray:self.vm_cell.model_cell.imagesURL];
    } else {
        NSLog(@"Attempt to set data. component which is equal nil : self.photoGallary");
    }
}



-(NSData*) getDataFromCacheByURL:(NSString*) urlStr
{
    return  [self.vm_cell.imageCache objectForKey:urlStr];
}
-(NSOperationQueue*) getOperationQueue
{
    return self.vm_cell.imageOperationQueue;
}
-(void) writeToCacheData:(NSData*) data urlKey:(NSString*) key
{
    [self.vm_cell.imageCache setObject:data forKey:key];
}



@end
