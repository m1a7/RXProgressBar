//
//  TableViewControllerMVC.m
//  RXProgressBar_Example
//
//  Created by Uber on 09/03/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import "TableViewControllerMVC.h"

// Cell's ViewModels from RXProgressBar
#import <RXProgressBar/RXBaseViewModelCell.h>
#import <RXProgressBar/RXBeginViewModelCell.h>
#import <RXProgressBar/RXMiddleViewModelCell.h>
#import <RXProgressBar/RXEndViewModelCell.h>

// Cell from RXProgressBar
#import <RXProgressBar/RXBaseCell.h>
#import <RXProgressBar/RXBeginCell.h>
#import <RXProgressBar/RXMiddleCell.h>
#import <RXProgressBar/RXEndCell.h>

// RXProgressBar's main core files
#import <RXProgressBar/RXCollectionPB.h>
#import <RXProgressBar/RXProgressBar.h>
#import <RXProgressBar/RXUIConfig.h>
#import <RXProgressBar/RXIndexPath.h>

// Psceudo dataSource
#import "DataBuilder.h"

// Thrid-party fraemwork (GIF Animation)
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>

@interface TableViewControllerMVC ()

@property (nonatomic, strong)  NSMutableArray* dataTableView; // Here store RXProgressBar's viewmodels and own models
@property (nonatomic, strong)  RXCollectionPB* pbCollection;  // Here store the progressbars aka instruction

@property (nonatomic, strong)  NSCache* imageCache;          // Here store cache images from all progressBar

@end

@implementation TableViewControllerMVC

/*
    Init all require components (arrays,object ect..) before using
*/
- (void)initAllRequiredComponent
{
    self.dataTableView = [NSMutableArray array];
    self.pbCollection  = [RXCollectionPB new];
    self.imageCache    = [[NSCache alloc] init];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.imageCache removeAllObjects];
}

#pragma mark - Life cycle of Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllRequiredComponent];
    
    __weak TableViewControllerMVC* bself = self;

    // Make pseudo request on server
    
    [self getDataFromURL:@"tra-ta-ta" onSuccess:^(BOOL successOperation) {
        [bself.tableView reloadData];
    } onFailure:^(NSError *errorBlock, NSObject *errObj) {
        
    }];
    
}
#pragma mark - pseudo data loading

- (void) getDataFromURL:(NSString*) url
              onSuccess:(void(^)(BOOL successOperation)) success
              onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure
{
    /*
      CREATE and INSERT First RXProgressBar
    */
    // Get array with object which conform with protocol "RXInstructionModelProtocol"
    NSArray<id<RXInstructionModelProtocol>>* dataForFirstInstruction = [DataBuilder createPumkinInstruction];
    
    // Create first RXProgressBar(aka."Instruction") with reference on RXCollectionPB (aka. "super collection")
    RXProgressBar* firstInstruction = [[RXProgressBar alloc] initWithCollectionPB:  self.pbCollection addAdditionalBeginAndEndCells: YES];
   
    // Select ui style for our RXProgressBar
    firstInstruction.configUI       = [[RXUIConfig alloc]    initConfigWithStyle: RXProgressBarStyle5];
   
    // Transform (object which conform with protocol "RXInstructionModelProtocol") to -> RXProgressBar's private viewmodel's cells
    NSArray* arrVMFromFirstBar      = [firstInstruction createVMfromModelsArray: dataForFirstInstruction withRefOnImgCache:self.imageCache];
    
    // Add these viewmodels to tableview datasource array
    [self.dataTableView addObjectsFromArray: arrVMFromFirstBar];
    [self.pbCollection addPB: firstInstruction];

    
    
    // Optional:  Add data for usually cell. (For Example)
    for (int i=0; i<=5; i++) {
        [self.dataTableView addObject: @"Insert Usually cell for example"];
    }
    
    /*
     CREATE and INSERT Second RXProgressBar
    */
    
    NSArray<id<RXInstructionModelProtocol>>* dataForSecondInstruction = [DataBuilder createTomAndJerryInstruction];
        
    RXProgressBar* secondInstruction = [[RXProgressBar alloc] initWithCollectionPB:  self.pbCollection addAdditionalBeginAndEndCells: YES];
    secondInstruction.configUI       = [[RXUIConfig alloc]    initConfigWithStyle: RXProgressBarStyle4];
    NSArray* arrVMFromSecondBar      = [secondInstruction createVMfromModelsArray: dataForSecondInstruction withRefOnImgCache:self.imageCache];
    
    [self.dataTableView addObjectsFromArray: arrVMFromSecondBar];
    [self.pbCollection addPB: secondInstruction];
}


#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.dataTableView count];
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40.f;
    // Get viewmodel from our datasource array
    id vm = [self.dataTableView objectAtIndex:indexPath.row];
    
    // depending on what kind of viewModel, will calculate the unique height

    if ([vm isKindOfClass:[RXBaseViewModelCell class]])
    {
        Class classOfCell = [RXBaseCell class];
        RXBaseViewModelCell* convetVM = (RXBaseViewModelCell*)vm;
        
        if ([convetVM isMemberOfClass:[RXBeginViewModelCell  class]]) classOfCell = [RXBeginCell  class];
        if ([convetVM isMemberOfClass:[RXMiddleViewModelCell class]]) classOfCell = [RXMiddleCell class];
        if ([convetVM isMemberOfClass:[RXEndViewModelCell    class]]) classOfCell = [RXEndCell    class];
        
        height = [classOfCell calculateHeightByUIConfig:convetVM.progressBar.configUI
                                                 withVM:vm
                                     withSuperViewWidth:CGRectGetWidth(self.tableView.frame)];
    }
    return roundf(height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;
    NSString* identifier = [self getClassNameByViewModelCell:[self.dataTableView objectAtIndex:indexPath.row]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
       [self configureCell:cell atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - UITableView helper methods

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{  
    // Support usually cell (UITableViewCell)
    if ([cell isMemberOfClass:[UITableViewCell class]]){
        cell.textLabel.text = [NSString stringWithFormat:@"Usually Your cell. IndexPath.row = %ld",(long)indexPath.row];
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }

    // Support RXProgressBar's cells (BeginCell/MiddleCell/EndCell)
    if ([cell isMemberOfClass:[RXBeginCell class]])
    {
        RXBeginCell* convertCell = (RXBeginCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
              convertCell.vm_cell = [self.dataTableView objectAtIndex:indexPath.row];
        }
    }

    if ([cell isMemberOfClass:[RXMiddleCell class]])
    {
        RXMiddleCell* convertCell = (RXMiddleCell*)cell;
        
                if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
                
                    convertCell.vm_cell.actualCalculationsForWidth = 0;
                    convertCell.vm_cell.actualCalculationsForHeight = 0;
                    
                    for (NSURLSessionDownloadTask* task in convertCell.vm_cell.arrConnection) {
                        [task cancel];
                    }
                    [convertCell.vm_cell.arrConnection removeAllObjects];
                    [convertCell cancelAllRequest];
                    convertCell.vm_cell   =  [self.dataTableView objectAtIndex:indexPath.row];
                }
                [convertCell.vm_cell.imageOperationQueue setSuspended:NO];
    }

    if ([cell isMemberOfClass:[RXEndCell class]])
    {
        RXEndCell* convertCell = (RXEndCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
             convertCell.vm_cell   =      [self.dataTableView objectAtIndex:indexPath.row];
        }
        [convertCell setupColors:convertCell.vm_cell andFrameSuperView:convertCell.contentView.frame andIndexInArray:0];
    }
}


#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // This part of code like example - "How delete RXProgressBar's cells ?"
        if ([[self.dataTableView objectAtIndex:indexPath.row] isKindOfClass:[RXBaseViewModelCell class]]){
            
            [self.dataTableView removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - Helpers TableView Methods
/*
  This is helpers method, which make work with -cellForRowAtIndexPath easy !
  Method return Class of viewmodel's objects.
  After in -cellForRowAtIndexPath init cell by returned class from this method
*/
- (NSString*) getClassNameByViewModelCell:(id) viewmodel
{
    NSString* identifier;
    if ([viewmodel isKindOfClass:[RXBeginViewModelCell  class]])  identifier = NSStringFromClass([RXBeginCell  class]);
    if ([viewmodel isKindOfClass:[RXMiddleViewModelCell class]])  identifier = NSStringFromClass([RXMiddleCell class]);
    if ([viewmodel isKindOfClass:[RXEndViewModelCell    class]])  identifier = NSStringFromClass([RXEndCell    class]);
    
    // Support usually cell (UITableViewCell)
    if ([viewmodel isKindOfClass:[NSString              class]])  identifier = NSStringFromClass([UITableViewCell class]);

    if (!identifier)
        identifier = NSStringFromClass([viewmodel class]);
    
    return identifier;
}


@end
