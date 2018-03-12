//
//  TableViewController.m
//  RXProgressBar_Example
//
//  Created by Uber on 27/02/2018.
//  Copyright © 2018 m1a7. All rights reserved.
//

#import "TableViewControllerMVVM.h"

// Own ViewModel for UITableView
#import "Table_ViewModel.h"

// Cell ViewModels from RXProgressBar
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
#import <RXProgressBar/RXProgressBar.h>
#import <RXProgressBar/RXUIConfig.h>
#import <RXProgressBar/RXIndexPath.h>

// Thrid-party fraemwork (GIF Animation)
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>

@interface TableViewControllerMVVM ()

// Own viewmodels for tableview
@property (nonatomic, strong) Table_ViewModel* vm_tableView;

@end

@implementation TableViewControllerMVVM

- (void) setVm_tableView:(Table_ViewModel *)vm_tableView
{
    __weak TableViewControllerMVVM* bself = self;

    _vm_tableView = vm_tableView;
    [_vm_tableView getDataFromURL:@"tra-ta-ta"
                        onSuccess:^(BOOL successOperation) {
                            [bself.tableView reloadData];
                        }
                        onFailure:^(NSError *errorBlock, NSObject *errObj) {
                            
                        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.vm_tableView = [[Table_ViewModel alloc] init];
     [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.vm_tableView countViewModels];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40.f;
    // Get viewmodel from our datasource array
    id vm = [self.vm_tableView cellViewModel:indexPath.row];
    
    // depending on what kind of viewModel, will calculate the unique height
    
    if ([vm isKindOfClass:[RXBaseViewModelCell class]])
    {
        Class classOfCell = [RXBaseCell class];
        RXBaseViewModelCell* convetVM = (RXBaseViewModelCell*)vm;
        
        if ([convetVM isMemberOfClass:[RXBeginViewModelCell  class]]) classOfCell = [RXBeginCell  class];
        if ([convetVM isMemberOfClass:[RXMiddleViewModelCell class]]) classOfCell = [RXMiddleCell class];
        if ([convetVM isMemberOfClass:[RXEndViewModelCell    class]]) classOfCell = [RXEndCell    class];
        
        height = [classOfCell calculateHeightByUIConfig:convetVM.progressBar.configUI
                                                 withVM:[self.vm_tableView cellViewModel:indexPath.row]
                                     withSuperViewWidth:CGRectGetWidth(self.tableView.frame)];
        }
    return roundf(height);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;
    NSString* identifier = [self getClassNameByViewModelCell:[self.vm_tableView cellViewModel:indexPath.row]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:cell atIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // This part of code like example - "How delete RXProgressBar's cells ?"
        if ([[self.vm_tableView cellViewModel:indexPath.row] isKindOfClass:[RXBaseViewModelCell class]]){
          
            // First step - convert indexPath(by NSIndexPath) to convertPath(RXIndexPath)
            /*
              This is necessary because, in the viewmodel you can't do import UIKit objects.
            */
            RXIndexPath* convertPath = [[RXIndexPath alloc]initWithRow:indexPath.row withSection:indexPath.section];
            
            // Second step - Ask from table's viewmodel - "Can I delete this cell ?"
            if ([self.vm_tableView canDeleteRowAtRXIndexPath: convertPath])
            {
                [self.vm_tableView deleteVMfromCellsArrayByIndexPath:convertPath];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}


#pragma mark - UITableView helper methods

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Support RXProgressBar's cells (BeginCell/MiddleCell/EndCell)

    if ([cell isMemberOfClass:[RXBeginCell class]])
    {
        RXBeginCell* convertCell = (RXBeginCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.vm_tableView cellViewModel:indexPath.row]]){
              convertCell.vm_cell = [self.vm_tableView cellViewModel:indexPath.row];
        }
    }

    if ([cell isMemberOfClass:[RXMiddleCell class]])
    {
        RXMiddleCell* convertCell = (RXMiddleCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.vm_tableView cellViewModel:indexPath.row]]){
              convertCell.vm_cell = [self.vm_tableView cellViewModel:indexPath.row];
        }
    }

    if ([cell isMemberOfClass:[RXEndCell class]])
    {
        RXEndCell* convertCell = (RXEndCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.vm_tableView cellViewModel:indexPath.row]]){
             convertCell.vm_cell = [self.vm_tableView cellViewModel:indexPath.row];
        }
        [convertCell setupColors:convertCell.vm_cell andFrameSuperView:convertCell.contentView.frame andIndexInArray:0];
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
    
    if (!identifier)
        identifier = NSStringFromClass([viewmodel class]);
    
    return identifier;
}

@end
