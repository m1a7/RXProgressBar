//
//  RXBaseCell.m
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import "RXBaseCell.h"

// Cell ViewModel - for (RXBeginCell & RXEndCell)
#import "RXBeginViewModelCell.h"
#import "RXEndViewModelCell.h"

// Cell - (RXBeginCell & RXMiddleCell & RXEndCell)
#import "RXBeginCell.h"
#import "RXMiddleCell.h"
#import "RXEndCell.h"

#import "UITableViewCell+RelatedTable.h"

#import "RXBeforeLine.h"
#import "RXAfterLine.h"


// Star Wars - font by - http://patorjk.com/software/taag

@implementation RXBaseCell

#pragma mark - Standart UITableViewCell methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}

-(void) layoutSubviews{
       [super layoutSubviews];
}

#pragma mark - Init and Add on SuperView (checkPoint|lineBeforePoint|lineAfterPoint)

///////////////////////////////////////////////////////////////////////////////////////////////////
/*
  __  .__   __.  __  .___________.    __    __   __     .______   .______        ______   .______    _______ .______     .___________.____    ____
 |  | |  \ |  | |  | |           |   |  |  |  | |  |    |   _  \  |   _  \      /  __  \  |   _  \  |   ____||   _  \    |           |\   \  /   /
 |  | |   \|  | |  | `---|  |----`   |  |  |  | |  |    |  |_)  | |  |_)  |    |  |  |  | |  |_)  | |  |__   |  |_)  |   `---|  |----` \   \/   /
 |  | |  . `  | |  |     |  |        |  |  |  | |  |    |   ___/  |      /     |  |  |  | |   ___/  |   __|  |      /        |  |       \_    _/
 |  | |  |\   | |  |     |  |        |  `--'  | |  |    |  |      |  |\  \----.|  `--'  | |  |      |  |____ |  |\  \----.   |  |         |  |
 |__| |__| \__| |__|     |__|         \______/  |__|    | _|      | _| `._____| \______/  | _|      |_______|| _| `._____|   |__|         |__|
  */
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void) initVerticalLineAndCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    // Inits
    self.checkPoint      = [[RXCheckPoint alloc] init];
    self.checkPoint.roundType = vm.progressBar.configUI.checkPointRoundDegree;
    
    // Set frame
    if ([vm isKindOfClass:[RXBeginViewModelCell  class]]){
        self.lineAfterPoint        = [RXAfterLine new];
        self.checkPoint.frame      =  [RXBaseCell cgrectBeginCellCheckPoint:vm andFrameSuperView:frame];
        self.lineAfterPoint.frame  =  [self cgrectBeginCellLineAfter:vm andFrameSuperView:frame];
    }
    if ([vm isKindOfClass:[RXEndViewModelCell  class]]){
        self.lineBeforePoint        = [RXBeforeLine new];
        self.checkPoint.frame       = [RXBaseCell cgrectEndCellCheckPoint:vm andFrameSuperView:frame];
        self.lineBeforePoint.frame  =  [self cgrectEndCellLineBefore:vm andFrameSuperView:frame];
    }
    if ([vm isKindOfClass:[RXMiddleViewModelCell  class]]){
        self.lineBeforePoint        = [RXBeforeLine new];
        self.lineAfterPoint        = [RXAfterLine new];

        self.checkPoint.frame      = [RXBaseCell cgrectMiddleCellCheckPoint:vm andFrameSuperView:frame];
        self.lineBeforePoint.frame = [self cgrectMiddleCellBeforeLine:vm andFrameSuperView:frame];
        self.lineAfterPoint.frame  = [self cgrectMiddleCellAfterLine:vm  andFrameSuperView:frame];
    }

    if (self.lineBeforePoint){
        [self.contentView addSubview: self.lineBeforePoint];
    }
    if (self.lineAfterPoint){
        [self.contentView addSubview: self.lineAfterPoint];
    }
    
    // AddSubview
    [self.contentView addSubview: self.checkPoint];
    [self setupColors:vm andFrameSuperView:frame andIndexInArray:index];
}

#pragma mark - Route methods which direct RXBaseCell on some set style method

///////////////////////////////////////////////////////////////////////////////////////////////////
/*
      _______. _______ .___________. __    __  .______       __    __   __     .______   .______        ______   .______    _______ .______     .___________.____    ____
     /       ||   ____||           ||  |  |  | |   _  \     |  |  |  | |  |    |   _  \  |   _  \      /  __  \  |   _  \  |   ____||   _  \    |           |\   \  /   /
    |   (----`|  |__   `---|  |----`|  |  |  | |  |_)  |    |  |  |  | |  |    |  |_)  | |  |_)  |    |  |  |  | |  |_)  | |  |__   |  |_)  |   `---|  |----` \   \/   /
     \   \    |   __|      |  |     |  |  |  | |   ___/     |  |  |  | |  |    |   ___/  |      /     |  |  |  | |   ___/  |   __|  |      /        |  |       \_    _/
 .----)   |   |  |____     |  |     |  `--'  | |  |         |  `--'  | |  |    |  |      |  |\  \----.|  `--'  | |  |      |  |____ |  |\  \----.   |  |         |  |
 |_______/    |_______|    |__|      \______/  | _|          \______/  |__|    | _|      | _| `._____| \______/  | _|      |_______|| _| `._____|   |__|         |__|
 */
///////////////////////////////////////////////////////////////////////////////////////////////////


- (void) setupColors:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    switch (vm.cellStatus) {
        case RXStatusCellIsDone:      [self setupCellInDoneStatus:vm    andFrameSuperView:frame andIndexInArray:index]; break;
        case RXStatusCellIsInProcess: [self setupCellInProcessStatus:vm andFrameSuperView:frame andIndexInArray:index]; break;
        case RXStatusCellIsInWaiting: [self setupCellInWaitingStatus:vm andFrameSuperView:frame andIndexInArray:index]; break;
        default: NSLog(@"Not found the style"); break;
    }
}


#pragma mark - Calculate height of Cell

///////////////////////////////////////////////////////////////////////////////////////////////////
/*
   ______     ___       __        ______     __    __   _______  __    _______  __    __  .___________.     ______    _______      ______  _______  __       __
  /      |   /   \     |  |      /      |   |  |  |  | |   ____||  |  /  _____||  |  |  | |           |    /  __  \  |   ____|    /      ||   ____||  |     |  |
 |  ,----'  /  ^  \    |  |     |  ,----'   |  |__|  | |  |__   |  | |  |  __  |  |__|  | `---|  |----`   |  |  |  | |  |__      |  ,----'|  |__   |  |     |  |
 |  |      /  /_\  \   |  |     |  |        |   __   | |   __|  |  | |  | |_ | |   __   |     |  |        |  |  |  | |   __|     |  |     |   __|  |  |     |  |
 |  `----./  _____  \  |  `----.|  `----.   |  |  |  | |  |____ |  | |  |__| | |  |  |  |     |  |        |  `--'  | |  |        |  `----.|  |____ |  `----.|  `----.
  \______/__/     \__\ |_______| \______|   |__|  |__| |_______||__|  \______| |__|  |__|     |__|         \______/  |__|         \______||_______||_______||_______|
 
*/
///////////////////////////////////////////////////////////////////////////////////////////////////

+ (CGFloat) calculateHeightByUIConfig:(RXUIConfig*) config withVM:(id<RXBaseViewModelCellProtocol>) vm  withSuperViewWidth:(CGFloat)width;
{
    return 40.f;
}

#pragma mark - Animate cell with in depending Cell Status

///////////////////////////////////////////////////////////////////////////////////////////////////
/*
   ______  __    __       ___      .__   __.   _______  _______         _______.___________.    ___   .___________. __    __       _______.     ______  _______  __       __
  /      ||  |  |  |     /   \     |  \ |  |  /  _____||   ____|       /       |           |   /   \  |           ||  |  |  |     /       |    /      ||   ____||  |     |  |
 |  ,----'|  |__|  |    /  ^  \    |   \|  | |  |  __  |  |__         |   (----`---|  |----`  /  ^  \ `---|  |----`|  |  |  |    |   (----`   |  ,----'|  |__   |  |     |  |
 |  |     |   __   |   /  /_\  \   |  . `  | |  | |_ | |   __|         \   \       |  |      /  /_\  \    |  |     |  |  |  |     \   \       |  |     |   __|  |  |     |  |
 |  `----.|  |  |  |  /  _____  \  |  |\   | |  |__| | |  |____    .----)   |      |  |     /  _____  \   |  |     |  `--'  | .----)   |      |  `----.|  |____ |  `----.|  `----.
  \______||__|  |__| /__/     \__\ |__| \__|  \______| |_______|   |_______/       |__|    /__/     \__\  |__|      \______/  |_______/        \______||_______||_______||_______|
*/
///////////////////////////////////////////////////////////////////////////////////////////////////


- (void) makeThisCellIsDoneStatus:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    __weak RXBaseCell* wself = self;
    vm.cellStatus = RXStatusCellIsDone;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop  animations:^{
        [wself setupCellInDoneStatus:vm  andFrameSuperView:frame andIndexInArray:index];
    } completion:^(BOOL finished) {
    }];
    
}

- (void) makeSelfStatusInProccess:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    __weak RXBaseCell* wself = self;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop  animations:^{
        [wself setupCellInProcessStatus:vm andFrameSuperView:frame andIndexInArray:index];
    } completion:^(BOOL finished) {
    }];
}

- (void) makeNextCellIsInProcessingStatus:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    // Take the index to our VM
    NSInteger idx = [vm.progressBar.allViewModels indexOfObject:vm];
    
    // Checks to see if the next VM is further in the array
    if (vm.progressBar.allViewModels.count > idx+1)
    {
        // Pulls a VM (from the next cell)
        RXBaseViewModelCell* vmFromNextCell = [vm.progressBar.allViewModels objectAtIndex:idx+1];
        
        // Assign the status "in process"
        if ([[vm.progressBar.allViewModels lastObject] isEqual:vmFromNextCell]){
            vmFromNextCell.cellStatus = RXStatusCellIsDone;
        }else {
            vmFromNextCell.cellStatus = RXStatusCellIsInProcess;
        }
        
        // Get a tableview
        UITableView *parentTable = [self relatedTable];
        
        // Just in case check whether the self.superview table
        if ([parentTable isKindOfClass:[UITableView class]]) {
            
           // Now we want to get the index of our cell in the array of visible table cells
            NSInteger idxSelfCellInVisibleArray = [parentTable.visibleCells indexOfObject:self];
            
            // Are there any checks for the next cell in the table ?!
            if(parentTable.visibleCells.count > idxSelfCellInVisibleArray+1)
            {
                // If there is then pull it out of the array
                UITableViewCell* nextCellInArr = [parentTable.visibleCells objectAtIndex:idxSelfCellInVisibleArray+1];
                
                // Then run through each possible cell type, convert, and call makeselfstatusinprocess
                if ([nextCellInArr isKindOfClass:[RXBeginCell class]])
                {
                    RXBeginCell* convertNextCellInArr = (RXBeginCell*)nextCellInArr;
                    [convertNextCellInArr makeSelfStatusInProccess: convertNextCellInArr.vm_cell
                                                 andFrameSuperView:convertNextCellInArr.contentView.frame
                                                   andIndexInArray:idx+1];
                }
                // Then run through each possible cell type, convert, and call makeselfstatusinprocess
                if ([nextCellInArr isKindOfClass:[RXMiddleCell class]])
                {
                    RXMiddleCell* convertNextCellInArr = (RXMiddleCell*)nextCellInArr;
                    [convertNextCellInArr makeSelfStatusInProccess: convertNextCellInArr.vm_cell
                                                 andFrameSuperView:convertNextCellInArr.contentView.frame
                                                   andIndexInArray:idx+1];
                }
                // Then run through each possible cell type, convert, and call makeselfstatusinprocess
                if ([nextCellInArr isKindOfClass:[RXEndCell class]])
                {
                    RXEndCell* convertNextCellInArr = (RXEndCell*)nextCellInArr;
                    
                    [convertNextCellInArr makeThisCellIsDoneStatus:convertNextCellInArr.vm_cell
                                                 andFrameSuperView:convertNextCellInArr.contentView.frame
                                                   andIndexInArray:0];
                }
            }
        }
    }
}

#pragma mark - Preparation of the cell in accordance with the status (InDoneStatus or InProcessStatus or InWaitingStatus)

- (void) setupCellInDoneStatus:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    // InDoneStatus
    if ([vm statusCellIsDone]){
        
        //  ContentView - Done State
        if (vm.progressBar.configUI.backgroundColorForDoneCell){
            self.contentView.backgroundColor = vm.progressBar.configUI.backgroundColorForDoneCell;
        }
        
        // CheckPoint - Done State
        if (vm.progressBar.configUI.doneCheckPointBackgroundColor){
            self.checkPoint.backgroundColor = vm.progressBar.configUI.doneCheckPointBackgroundColor;
        } else {
            self.checkPoint.backgroundColor = vm.progressBar.configUI.backgroundColorForCell;
              }
        
        if (vm.progressBar.configUI.doneCheckPointBorderWidth){
            self.checkPoint.layer.borderWidth = vm.progressBar.configUI.doneCheckPointBorderWidth;
            if (vm.progressBar.configUI.doneCheckPointBorderColor){
                self.checkPoint.layer.borderColor = vm.progressBar.configUI.doneCheckPointBorderColor.CGColor;
            }
        } else {
            self.checkPoint.layer.borderWidth = 0.f;
        }
        
        if (vm.progressBar.configUI.doneCheckPointFont){
            self.checkPoint.font = vm.progressBar.configUI.doneCheckPointFont;
        }
        if (vm.progressBar.configUI.doneCheckPointFontColor){
            self.checkPoint.textColor = vm.progressBar.configUI.doneCheckPointFontColor;
        }
        
        // LineColor - Done State
        if (vm.progressBar.configUI.doneLineColorBackgroundColor){
            self.lineBeforePoint.backgroundColor = vm.progressBar.configUI.doneLineColorBackgroundColor;
            self.lineAfterPoint.backgroundColor = vm.progressBar.configUI.doneLineColorBackgroundColor;
        }
        if (vm.progressBar.configUI.doneLineColorBorderColor ){
            self.lineBeforePoint.layer.borderColor = vm.progressBar.configUI.doneCheckPointBorderColor.CGColor;
            self.lineAfterPoint.layer.borderColor  = vm.progressBar.configUI.doneCheckPointBorderColor.CGColor;
        }
        if (vm.progressBar.configUI.doneLineColorBorderWidth > 0){
            self.lineBeforePoint.layer.borderWidth = vm.progressBar.configUI.doneCheckPointBorderWidth;
            self.lineAfterPoint.layer.borderWidth  = vm.progressBar.configUI.doneCheckPointBorderWidth;
        }
    }
    [self addSupportTextInCheckPointAndImage:vm andFrameSuperView:frame andIndexInArray:index];
}


- (void) setupCellInProcessStatus:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    // InProcessStatus
    if ([vm statusCellInProcess]){
        
        //  ContentView - Done State
        if (vm.progressBar.configUI.backgroundColorForProcessCell){
            self.contentView.backgroundColor = vm.progressBar.configUI.backgroundColorForProcessCell;
        }
        
        // CheckPoint - Proccess State
        if (vm.progressBar.configUI.inProcessCheckPointBackgroundColor){
            self.checkPoint.backgroundColor = vm.progressBar.configUI.inProcessCheckPointBackgroundColor;
        }
        if (vm.progressBar.configUI.inProcessCheckPointBorderColor){
            self.checkPoint.layer.borderColor = vm.progressBar.configUI.inProcessCheckPointBorderColor.CGColor;
        }
        if (vm.progressBar.configUI.inProcessCheckPointBorderWidth){
            self.checkPoint.layer.borderWidth = vm.progressBar.configUI.inProcessCheckPointBorderWidth;
        }
        if (vm.progressBar.configUI.inProcessCheckPointFont){
            self.checkPoint.font = vm.progressBar.configUI.inProcessCheckPointFont;
        }
        if (vm.progressBar.configUI.inProcessCheckPointFontColor){
            self.checkPoint.textColor = vm.progressBar.configUI.inProcessCheckPointFontColor;
        }
        
        // Lines - Proccess State
        if (vm.progressBar.configUI.inProcessLineColorBackgroundColor){
            self.lineBeforePoint.backgroundColor = vm.progressBar.configUI.inProcessLineColorBackgroundColor;
            self.lineAfterPoint.backgroundColor = vm.progressBar.configUI.inProcessLineColorBackgroundColor;
        }
        if (vm.progressBar.configUI.inProcessLineColorBorderColor ){
            self.lineBeforePoint.layer.borderColor = vm.progressBar.configUI.inProcessLineColorBorderColor.CGColor;
            self.lineAfterPoint.layer.borderColor  = vm.progressBar.configUI.inProcessLineColorBorderColor.CGColor;
        }
        if (vm.progressBar.configUI.inProcessLineColorBorderWidth > 0){
            self.lineBeforePoint.layer.borderWidth = vm.progressBar.configUI.inProcessLineColorBorderWidth;
            self.lineAfterPoint.layer.borderWidth  = vm.progressBar.configUI.inProcessLineColorBorderWidth;
        }
    }
    [self addSupportTextInCheckPointAndImage:vm andFrameSuperView:frame andIndexInArray:index];
}

- (void) setupCellInWaitingStatus:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    // InWaitingStatus
    if ([vm statusCellIsWaiting]){
        
        //  ContentView - Done State
        if (vm.progressBar.configUI.backgroundColorForWaitingCell){
            self.contentView.backgroundColor = vm.progressBar.configUI.backgroundColorForWaitingCell;
        }
        
        // CheckPoint - Waiting State
        if (vm.progressBar.configUI.inWaitingCheckPointBackgroundColor){
            self.checkPoint.backgroundColor = vm.progressBar.configUI.inWaitingCheckPointBackgroundColor;
        }
        if (vm.progressBar.configUI.inWaitingCheckPointBorderColor){
            self.checkPoint.layer.borderColor = vm.progressBar.configUI.inWaitingCheckPointBorderColor.CGColor;
        }
        if (vm.progressBar.configUI.inWaitingCheckPointBorderWidth){
            self.checkPoint.layer.borderWidth = vm.progressBar.configUI.inWaitingCheckPointBorderWidth;
        }
        if (vm.progressBar.configUI.inWaitingCheckPointFont){
            self.checkPoint.font = vm.progressBar.configUI.inWaitingCheckPointFont;
        }
        if (vm.progressBar.configUI.inWaitingCheckPointFontColor){
            self.checkPoint.textColor = vm.progressBar.configUI.inWaitingCheckPointFontColor;
        }
        
        // Lines - Waiting State
        if (vm.progressBar.configUI.inWaitingLineColorBackgroundColor){
            self.lineBeforePoint.backgroundColor = vm.progressBar.configUI.inWaitingLineColorBackgroundColor;
            self.lineAfterPoint.backgroundColor = vm.progressBar.configUI.inWaitingLineColorBackgroundColor;
        }
        if (vm.progressBar.configUI.inWaitingLineColorBorderColor ){
            self.lineBeforePoint.layer.borderColor = vm.progressBar.configUI.inWaitingLineColorBorderColor.CGColor;
            self.lineAfterPoint.layer.borderColor  = vm.progressBar.configUI.inWaitingLineColorBorderColor.CGColor;
        }
        if (vm.progressBar.configUI.inWaitingLineColorBorderWidth > 0){
            self.lineBeforePoint.layer.borderWidth = vm.progressBar.configUI.inWaitingLineColorBorderWidth;
            self.lineAfterPoint.layer.borderWidth  = vm.progressBar.configUI.inWaitingLineColorBorderWidth;
        }
    }
    [self addSupportTextInCheckPointAndImage:vm andFrameSuperView:frame andIndexInArray:index];
}



- (void) addSupportTextInCheckPointAndImage:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame andIndexInArray:(NSInteger) index
{
    //  Add text to Checkpoint
    if (index>0){
        if ((vm.progressBar.configUI.pbStyle == RXProgressBarStyle3) ||
            (vm.progressBar.configUI.pbStyle == RXProgressBarStyle4) ||
            (vm.progressBar.configUI.pbStyle == RXProgressBarStyle5))  {
            
            self.checkPoint.text = [NSString stringWithFormat:@"%ld",(long)index];
        }
    }
    // Add Image support
    if (vm.progressBar.configUI.doneCheckPointImage ||  vm.progressBar.configUI.inProcessCheckPointImage ||   vm.progressBar.configUI.inWaitingCheckPointImage)
    {
        UIImageView* img  = [[UIImageView alloc] initWithFrame:self.checkPoint.bounds];
        img.contentMode =  UIViewContentModeScaleAspectFit;
        img.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        img.layer.drawsAsynchronously = YES;
      
        if ([vm statusCellIsDone]){
            if (vm.progressBar.configUI.doneCheckPointImage){
                img.image = vm.progressBar.configUI.doneCheckPointImage;
                [self.checkPoint addSubview:img];
            }
        }
        
        if ([vm statusCellInProcess]){
            if (vm.progressBar.configUI.inProcessCheckPointImage){
                img.image = vm.progressBar.configUI.inProcessCheckPointImage;
                [self.checkPoint addSubview:img];
            }
        }
        
        if ([vm statusCellIsWaiting]){
            if (vm.progressBar.configUI.inWaitingCheckPointImage){
                img.image = vm.progressBar.configUI.inWaitingCheckPointImage;
                [self.checkPoint addSubview:img];
            }
        }
    }
}



#pragma mark - Methods Get CGRect frame for (checkPoint|lineBeforePoint|lineAfterPoint)

///////////////////////////////////////////////////////////////////////////////////////////////////
/*
  _______  _______  .___________.        ______   _______ .______       _______   ______ .___________.     ______   ______   .__   __.  _______  __    _______
 /  _____| |   ____||           |       /      | /  _____||   _  \     |   ____| /      ||           |    /      | /  __  \  |  \ |  | |   ____||  |  /  _____|
 |  |  __  |  |__   `---|  |----`      |  ,----'|  |  __  |  |_)  |    |  |__   |  ,----'`---|  |----`   |  ,----'|  |  |  | |   \|  | |  |__   |  | |  |  __
 |  | |_ | |   __|      |  |           |  |     |  | |_ | |      /     |   __|  |  |         |  |        |  |     |  |  |  | |  . `  | |   __|  |  | |  | |_ |
 |  |__| | |  |____     |  |           |  `----.|  |__| | |  |\  \----.|  |____ |  `----.    |  |        |  `----.|  `--'  | |  |\   | |  |     |  | |  |__| |
 \_______| |_______|    |__|            \______| \______| | _| `._____||_______| \______|    |__|         \______| \______/  |__| \__| |__|     |__|  \______|
 
 */
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma - CGRect for RXBeginCell

+ (CGRect)cgrectBeginCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // BeginCell - CheckPoint
    float width  = (CGRectGetWidth(frame)/100)*vm.progressBar.configUI.widthPercentCheckPointAndLine;
    float horizontalOffsetFromLeftAndRight = (width/100)*10;
    width -= horizontalOffsetFromLeftAndRight*2;
    float height = width;
    float offsetFromTop  = vm.progressBar.configUI.standartOffSetBetweenUIComponents;
    
    float x = horizontalOffsetFromLeftAndRight;
    float y = offsetFromTop;
    return CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height));
    
}

- (CGRect)cgrectBeginCellLineAfter:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
     // BeginCell - AfterLine
    CGFloat weightLine =  CGRectGetWidth(self.checkPoint.frame)/6;
    CGFloat xLine      =  CGRectGetMidX(self.checkPoint.frame)-weightLine/2;
    
    float heightFromMaxYcheckPointToBottomCell =   CGRectGetHeight(frame)-CGRectGetMaxY(self.checkPoint.frame);
    float percentOffSetFromTop    = (heightFromMaxYcheckPointToBottomCell/100)*vm.progressBar.configUI.percentOffsetFromTop;
    float percentOffSetFromBottom = (heightFromMaxYcheckPointToBottomCell/100)*vm.progressBar.configUI.percentOffsetFromBottom;

    CGFloat yLine      =  CGRectGetMaxY(self.checkPoint.frame)+percentOffSetFromTop;
    CGFloat heightLine =  CGRectGetHeight(frame)-CGRectGetMaxY(self.checkPoint.frame)-(percentOffSetFromTop+percentOffSetFromBottom);

    CGRect rectLine    = CGRectMake(roundf(xLine), roundf(yLine), roundf(weightLine), roundf(heightLine));
    return rectLine;
}

#pragma - CGRect for RXEndCell

// CGRect for RXEndCell
+ (CGRect)cgrectEndCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // RXEndCell - CheckPoint
    float maxYcell = CGRectGetMaxY(frame);
    float width   = (CGRectGetWidth(frame)/100)*vm.progressBar.configUI.widthPercentCheckPointAndLine;
    
    float horizontalOffsetFromLeftAndRight = (width/100)*10;
    width -= horizontalOffsetFromLeftAndRight*2;
    float height = width;
    float x = horizontalOffsetFromLeftAndRight;
    float y = maxYcell - (vm.progressBar.configUI.standartOffSetBetweenUIComponents + height);
    return CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height));
    
}

- (CGRect)cgrectEndCellLineBefore:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // RXEndCell - BeforeLine
    float heightFromMaxYcheckPointToBottomCell = CGRectGetMinY(self.checkPoint.frame);
    float percentOffSetFromTop    = (heightFromMaxYcheckPointToBottomCell/100)*vm.progressBar.configUI.percentOffsetFromTop;
    float percentOffSetFromBottom = (heightFromMaxYcheckPointToBottomCell/100)*vm.progressBar.configUI.percentOffsetFromBottom;
    
    CGFloat weightLine =  CGRectGetWidth(self.checkPoint.frame)/6;
    CGFloat xLine      =  CGRectGetMidX(self.checkPoint.frame)-weightLine/2;
    CGFloat yLine      =  (percentOffSetFromTop) ? percentOffSetFromTop : 0.f;
    CGFloat heightLine =  heightFromMaxYcheckPointToBottomCell-(percentOffSetFromTop+percentOffSetFromBottom+percentOffSetFromTop);
    CGRect rectLine    = CGRectMake(roundf(xLine), roundf(yLine), roundf(weightLine), roundf(heightLine));
    return rectLine;
}


#pragma - CGRect for RXMiddleCell


+ (CGRect)cgrectMiddleCellCheckPoint:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // RXMiddleCell - CheckPoint
    float width  = (CGRectGetWidth(frame)/100)*vm.progressBar.configUI.widthPercentCheckPointAndLine;
    float horizontalOffsetFromLeftAndRight = (width/100)*10;
    width -= horizontalOffsetFromLeftAndRight*2;
    float height = width;
    
    float offsetFromTop  = vm.progressBar.configUI.standartOffSetBetweenUIComponents;
    
    float x = horizontalOffsetFromLeftAndRight;
    float y = offsetFromTop;

    return CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height));
}


- (CGRect)cgrectMiddleCellBeforeLine:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // RXMiddleCell - BeforeLine
    float minYcell       = CGRectGetMinY(self.contentView.frame);
    float minYcheckPoint = CGRectGetMinY(self.checkPoint.frame);
    
    float height         = minYcheckPoint - minYcell;
    float percentOffSetFromTop    = (height/100)*vm.progressBar.configUI.percentOffsetFromTop;
    float percentOffSetFromBottom = (height/100)*vm.progressBar.configUI.percentOffsetFromBottom;
    height -= percentOffSetFromTop;
    height -= percentOffSetFromBottom;
    
    float width  =  CGRectGetWidth(self.checkPoint.frame)/6;
    float y     = (percentOffSetFromTop) ? percentOffSetFromTop : minYcell;
    float x = CGRectGetMidX(self.checkPoint.frame)-width/2;
    
    return  CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height));
}


- (CGRect)cgrectMiddleCellAfterLine:(id<RXBaseViewModelCellProtocol>)vm andFrameSuperView:(CGRect)frame
{
    // RXMiddleCell - AfterLine

    float maxYcheckPoint = CGRectGetMaxY(self.checkPoint.frame);
    float maxYcell       = CGRectGetMaxY(self.contentView.frame);
    float height         = maxYcell - maxYcheckPoint;

    float percentOffSetFromTop    = (height/100)*vm.progressBar.configUI.percentOffsetFromTop;
    float percentOffSetFromBottom = (height/100)*vm.progressBar.configUI.percentOffsetFromBottom;
    height -= percentOffSetFromTop;
    height -= percentOffSetFromBottom;

    float width  =  CGRectGetWidth(self.checkPoint.frame)/6;
    float y = maxYcheckPoint+percentOffSetFromTop;
    float x = CGRectGetMidX(self.checkPoint.frame)-width/2;
    
    return CGRectMake(roundf(x), roundf(y), roundf(width), roundf(height));
}



@end
