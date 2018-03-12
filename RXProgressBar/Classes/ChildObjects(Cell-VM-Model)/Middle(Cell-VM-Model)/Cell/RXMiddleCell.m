//
//  RXMiddleCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXMiddleCell.h"

#import "RXWrapperNYTPhoto.h"

// Thrid-party fraemwork
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>
#import <NYTPhotoViewer/NYTPhotoViewerArrayDataSource.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>

#import "RXUIConfig.h"
#import "RXBeforeLine.h"
#import "RXAfterLine.h"

@interface RXMiddleCell () <NYTPhotosViewControllerDelegate, NYTPhotoViewerDataSource>

// Private properties for NYTPhotoViewer
@property(strong, nonatomic) NSMutableArray<RXWrapperNYTPhoto*>* imageForNYTPhotosVC;
@property(strong, nonatomic) NSNumber    *numberOfPhotos;
@property(strong, nonatomic) UIImageView *touchedImgView;

@end

@implementation RXMiddleCell

#pragma mark - Standart UITableViewCell methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected)
    {
    if ([self.vm_cell statusCellInProcess])
    {
        NSInteger idxInArr = [self.vm_cell.progressBar.allViewModels
                              indexOfObject:self.vm_cell];
        
        if (!self.vm_cell.progressBar.addAdditionalBeginAndEndCells){
            idxInArr +=1;
        }
        [self makeThisCellIsDoneStatus:self.vm_cell
                     andFrameSuperView:self.contentView.frame
                       andIndexInArray:idxInArr];
        [self makeNextCellIsInProcessingStatus:self.vm_cell
                             andFrameSuperView:self.contentView.frame
                               andIndexInArray:idxInArr];
    }
   }
}

#pragma mark - Layout/Resize subview

-(void) layoutSubviews{
    [super layoutSubviews];
    [self  resizeSubviews];
}

- (void) resizeSubviews
{
    if    ((self.vm_cell.actualCalculationsForWidth != self.contentView.frame.size.width)
        || (self.vm_cell.actualCalculationsForHeight != self.contentView.frame.size.height))
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
            self.photoGallary.frame = [RXMiddleCell rectForPhotoGallary:self.contentView.frame
                                                                withVM:self.vm_cell
                                                heightInstructionLabel:CGRectGetHeight(self.instructionLabel.frame)];
            
            _vm_cell.x_PhotoGallary      = self.photoGallary.frame.origin.x;
            _vm_cell.y_PhotoGallary      = self.photoGallary.frame.origin.y;
            _vm_cell.width_PhotoGallary  = self.photoGallary.frame.size.width;
            _vm_cell.height_PhotoGallary = self.photoGallary.frame.size.height;
        }
        
        
        if ( self.checkPoint){
            self.checkPoint.frame  = [RXBaseCell cgrectMiddleCellCheckPoint:self.vm_cell andFrameSuperView:self.contentView.frame];
             self.vm_cell.height_CheckPoint = CGRectGetHeight(self.checkPoint.frame);
        }
     
        if (self.lineBeforePoint){
            self.lineBeforePoint.frame = [self cgrectMiddleCellBeforeLine:self.vm_cell andFrameSuperView:self.contentView.frame];
        }
        if (self.lineAfterPoint){
            self.lineAfterPoint.frame  = [self cgrectMiddleCellAfterLine:self.vm_cell  andFrameSuperView:self.contentView.frame];
        }
   
        self.vm_cell.actualCalculationsForWidth  = CGRectGetWidth(self.contentView.frame);
        self.vm_cell.actualCalculationsForHeight = CGRectGetHeight(self.contentView.frame);
    }
}

#pragma mark - UI methods

- (void) initUIComponentsWithVM:(RXMiddleViewModelCell*)vm
{
    NSInteger idxInArr = [self.vm_cell.progressBar.allViewModels indexOfObject:self.vm_cell];
 
    if (!self.vm_cell.progressBar.addAdditionalBeginAndEndCells){
        idxInArr +=1;
    }
    [self initVerticalLineAndCheckPoint:vm andFrameSuperView:self.contentView.frame andIndexInArray:idxInArr];
    
    if (vm.model_cell.instruction.length > 0)
    {
        self.instructionLabel   = [[UILabel alloc] init];
        [self setupInstructionLabel];
        [self.contentView addSubview:self.instructionLabel];
    }
    if (vm.model_cell.imagesURL.count > 0)
    {
        self.photoGallary  = [[RXLayoutGallary alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andDelegate:self];
        [self setupPhotoGallary];
        [self.contentView addSubview:self.photoGallary];
    }
    
    for (UIView* subView in self.contentView.subviews) {
        subView.layer.drawsAsynchronously = YES;
    }
}

- (void) setInNilAllComponent
{
    [self cancelAllRequest];
    
    for (UIView* subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (id subview in self.photoGallary.subviews) {
        if ([subview isKindOfClass:[FLAnimatedImageView class]])
        {
            FLAnimatedImageView* convertSubview = (FLAnimatedImageView*)subview;
            [convertSubview stopAnimating];
            convertSubview.animatedImage = nil;
            [convertSubview removeFromSuperview];
            convertSubview = nil;
        }

    }
        
    self.instructionLabel = nil;
    self.photoGallary    = nil;
    self.checkPoint      = nil;
    self.lineBeforePoint = nil;
    self.lineAfterPoint  = nil;
}


#pragma mark -  Setter for ViewModel
- (void) setVm_cell:(RXMiddleViewModelCell *)vm_cell{
    _vm_cell = vm_cell;
    [self setDataToCell];
}

- (void) setDataToCell {

    __weak RXMiddleCell* bself = self;
    CGFloat width =CGRectGetWidth(bself.contentView.frame);
    CGFloat height =CGRectGetHeight(bself.contentView.frame);

    [bself setInNilAllComponent];
    [bself initUIComponentsWithVM:bself.vm_cell];
    
    if (bself.vm_cell.model_cell.instruction.length > 0){
      
        if (bself.vm_cell.height_InstructionLabel <= 0) {
            bself.vm_cell.height_InstructionLabel =  [RXMiddleCell heigtForCellwithString: _vm_cell.model_cell.instruction
                                                                                 withFont: self.vm_cell.progressBar.configUI.mainLabelFont
                                                                           withWidthLabel: ((width/100)*bself.vm_cell.progressBar.configUI.widthPercentInstructionAndGallary)- bself.vm_cell.progressBar.configUI.standartOffSetBetweenUIComponents*2].height;
        }
        [bself setDataToInstructionLabel];
    }
    
    if (bself.vm_cell.model_cell.imagesURL.count > 0) {
        
        if (bself.vm_cell.height_PhotoGallary <= 0){
            bself.vm_cell.height_PhotoGallary = [RXMiddleCell rectForPhotoGallary:CGRectMake(0, 0, width, 0)
                                                                           withVM:bself.vm_cell
                                                           heightInstructionLabel: bself.vm_cell.height_InstructionLabel].size.height;
        }
        [bself setDataToPhotoGallary];
    }
    
    
    if (self.vm_cell.actualCalculationsForWidth == width &&  self.vm_cell.actualCalculationsForHeight == height){
       [self setFramesSettingFromVMtoSubviews];
    }
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

#pragma mark - Setup UI Components

- (void) setupInstructionLabel
{
    if (self.instructionLabel){
        self.instructionLabel.numberOfLines   = 0;
        self.instructionLabel.textColor       = [UIColor whiteColor];
        self.instructionLabel.font            = self.vm_cell.progressBar.configUI.mainLabelFont;
        self.instructionLabel.textColor       = self.vm_cell.progressBar.configUI.mainLabelFontColor;
        self.instructionLabel.backgroundColor = self.vm_cell.progressBar.configUI.backgroundColorForCell;
    } else {
        NSLog(@"Attempt to initialize component which is equal nil : instructionLabel");
    }
}

- (void) setupPhotoGallary{
    if (self.photoGallary){
        self.photoGallary.backgroundColor = self.vm_cell.progressBar.configUI.backgroundColorForCell;
    } else {
        NSLog(@"Attempt to initialize component which is equal nil : photoGallary");
    }
}

#pragma mark - Set data to UI Components

-(void) setDataToInstructionLabel{
    if (self.instructionLabel && self.vm_cell.model_cell.instruction){
        self.instructionLabel.text = self.vm_cell.model_cell.instruction;
    } else {
        NSLog(@"Attempt to set data. component which is equal nil : self.instructionLabel");
    }
}

-(void) setDataToPhotoGallary{
    if (self.photoGallary && self.vm_cell.model_cell.imagesURL.count > 0){
        [self.photoGallary addImagesFromMixArray:self.vm_cell.model_cell.imagesURL];
    } else {
        NSLog(@"Attempt to set data. component which is equal nil : self.photoGallary");
    }
}



#pragma mark - Calculate height of Cell

+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config withVM:(id<RXBaseViewModelCellProtocol>) vm  withSuperViewWidth:(CGFloat)width
{
    RXMiddleViewModelCell* convertVM;
    if ([vm isKindOfClass:[RXMiddleViewModelCell class]]){
         convertVM = (RXMiddleViewModelCell*)vm;
    }

    if (convertVM.height_CheckPoint <= 0 || convertVM.actualCalculationsForWidth != width)
    {
       convertVM.height_CheckPoint  = [RXMiddleCell cgrectMiddleCellCheckPoint:vm andFrameSuperView:CGRectMake(0, 0, width, 0)].size.height;
    }
    
    if (convertVM.model_cell.instruction.length > 0)
    {
        if (convertVM.height_InstructionLabel <= 0 || convertVM.actualCalculationsForWidth != width)
        {
            convertVM.height_InstructionLabel = [RXMiddleCell heigtForCellwithString: convertVM.model_cell.instruction
                                                                     withFont: convertVM.progressBar.configUI.mainLabelFont
                                                               withWidthLabel:  ((width/100)*vm.progressBar.configUI.widthPercentInstructionAndGallary)-vm.progressBar.configUI.standartOffSetBetweenUIComponents*2].height;
        }
    }
    
    if (convertVM.model_cell.imagesURL.count > 0)
    {
        if (convertVM.height_PhotoGallary <= 0 || convertVM.actualCalculationsForWidth != width)
        {
            convertVM.height_PhotoGallary      =  [RXMiddleCell rectForPhotoGallary:CGRectMake(0, 0, width, 0)
                                                                             withVM:convertVM
                                                             heightInstructionLabel:convertVM.height_InstructionLabel].size.height;
        }
    }
    
    float height  = [convertVM getTotalHeightWithOffset:vm.progressBar.configUI.standartOffSetBetweenUIComponents];
    return height;
}

#pragma mark - Helpers Calculate method height

+(CGSize)heigtForCellwithString:(NSString *)stringValue withFont:(UIFont*)font withWidthLabel:(CGFloat)width{
    CGFloat offsetHeight = width/17; 
    CGSize constraint = CGSizeMake(roundf(width),CGFLOAT_MAX);
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [stringValue boundingRectWithSize:constraint
                                            options:         (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil];
    return CGSizeMake(roundf(rect.size.width), roundf(rect.size.height+offsetHeight));
}

#pragma mark - UI Helpers methods

- (void) reloadTabelView
{
    UITableView *parentTable = (UITableView *)self.superview;
    if (![parentTable isKindOfClass:[UITableView class]]) {
        parentTable = (UITableView *) parentTable.superview;
    }
    [parentTable reloadData];
}


#pragma mark - ThridParty Fraemwork method
#pragma mark - RXLayoutGallaryDelegate

-(void) rxgallaryView:(RXLayoutGallary *)rxlayoutGallary didTapAtImageView:(UIImageView *)imageView sourceObject:(id)sourceImage atIndex:(NSUInteger)index
{
   self.imageForNYTPhotosVC = [NSMutableArray new];;
    self.numberOfPhotos      = [NSNumber numberWithInteger:rxlayoutGallary.imagesArray.count];
    self.touchedImgView      = imageView;
   
    __weak RXMiddleCell* bself = self;

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
                    
            [bself.imageForNYTPhotosVC addObject:({
                p.imageData = flaImgView.animatedImage.data;
                p;
            })];
            
        } else
            // If the UIImageView object is Lying, then such actions
            if ([imgFromGallary isKindOfClass:[UIImageView class]])
            {
                UIImageView* imageView = (UIImageView*)imgFromGallary;
                [bself.imageForNYTPhotosVC addObject:({
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
    CGFloat offset = self.vm_cell.progressBar.configUI.standartOffSetBetweenUIComponents;
    CGFloat height =  (self.vm_cell.height_InstructionLabel) ? _vm_cell.height_InstructionLabel : 40.f;
    CGFloat weight =  ((CGRectGetWidth(superViewFrame)/100)* self.vm_cell.progressBar.configUI.widthPercentInstructionAndGallary)-offset*2;
    CGFloat x      =  ((CGRectGetWidth(superViewFrame)/100)* (100-self.vm_cell.progressBar.configUI.widthPercentInstructionAndGallary))+offset;
    CGFloat y      =  offset;
    CGRect rect = CGRectMake(roundf(x), roundf(y), roundf(weight), roundf(height));
    return rect;
}


+ (CGRect) rectForPhotoGallary:(CGRect) superViewFrame withVM:(id<RXBaseViewModelCellProtocol>) vm heightInstructionLabel:(CGFloat) heightInstruction
{
    float percent = vm.progressBar.configUI.widthPercentInstructionAndGallary;
    CGFloat offset = vm.progressBar.configUI.standartOffSetBetweenUIComponents;
    CGFloat weight = ((CGRectGetWidth(superViewFrame)/100)*percent)-offset*2;
    CGFloat height = roundf(weight/2);
    CGFloat x      = ((CGRectGetWidth(superViewFrame)/100)*(100-percent))+offset;
    CGFloat y = 0;
    if (heightInstruction>0)
        y = offset+heightInstruction+offset;
    else
        y = offset;
    
    CGRect  rect   = CGRectMake(roundf(x), roundf(y), roundf(weight), roundf(height));
    return rect;
}


#pragma mark - Methods for caching image

-(NSData*) getDataFromCacheByURL:(NSString*) urlStr {
    return  [self.vm_cell.imageCache objectForKey:urlStr];
}

-(NSOperationQueue*) getOperationQueue {
    return self.vm_cell.imageOperationQueue;
}

- (void) cancelAllRequest {
    [self.vm_cell.imageOperationQueue setSuspended:YES];
    [self.vm_cell.imageOperationQueue cancelAllOperations];
}

-(void) writeToCacheData:(NSData*) data urlKey:(NSString*) key {
    [self.vm_cell.imageCache setObject:data forKey:key];
}

-(NSArray*) arrayURLSessionTask{
    return self.vm_cell.arrConnection;
}

-(void) addURLSessionDownTaskToArray:(NSURLSessionDownloadTask*) downloadTask {
    [self.vm_cell.arrConnection addObject:downloadTask];
}
@end
